//
//  Auth.swift
//  doharmony
//
//  Created by Mark Bermillo on 24/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//
// User authentication
// Provides functions for checking tokens of a user, logging in, and logout
//

import Foundation
import Alamofire
import SwiftyJSON
import UIKit
import CoreData

class Auth {
    
    // Login URL
    private let serverURL = "http://192.168.0.137:8080/api/login";
    
    /*
    Checks if the current user has an existing token saved on the device
    Returns true if there's an existing token (renews the token if it has expired)
    Returns false if there's no existing token on the device.
    */
    func isUserLoggedIn() -> Bool {
        var loggedIn = false;
        let dateNow = NSDate().description;
        let renewTokenURL = "http://192.168.0.137:8080/api/token";
        
        // Check if there's an existing token on the device
        let token = getToken();

        if token.count > 0 {
            // There's an existing token, check if it's still hasn't expired
            loggedIn = true;
            let validityDate = token["validityDate"]!;
            let tokenValue = token["token"]!;
            
            let dateComparisonResult: NSComparisonResult = dateNow.compare(validityDate);
            
            // Compare dateNow and `token["validityDate"]`
            if dateComparisonResult == NSComparisonResult.OrderedDescending {
                print("Token has expired");
                // Get a new token from the server (and attach the expired token)
                let parameters = ["token" : tokenValue];
                
                Alamofire.request(.PUT, renewTokenURL, parameters: parameters, encoding: .JSON)
                    .validate()
                    .responseJSON { response in
                        switch(response.result) {
                        case .Success:
                            let data = JSON(response.result.value!)
                            self.saveToken(data["data"]["token"].stringValue, validityDate: data["data"]["validityDate"].stringValue);

                        case .Failure(let error):
                            print("HTTP RESPONSE: \n\(error.localizedDescription)");
                        }
                }
            }
            
        } else {
            // There's no existing token on the device, The user is not logged in
            loggedIn =  false;
        }
        
        return loggedIn;
    }
    
    /*
    Send a login request to the server with parameters `username` and `password`
    
    edit: since alamofire makes asynchronous requests,
    a `completionHandler` is needed to be called once the
    fetching of data has completed
    
    Usage:
    auth.login(uname,pwd) { error in
        if error == nil { // there are no errors
            // code here for successful login
        } else { // there are errors
            // code here to display `error` variable 
            print(error.localizedDescription);
        }
    }
    */
    func login(username: String, password: String, completionHandler: (NSError?) -> Void) {
        let parameters = [
            "username" : username,
            "password" : password
        ];
        
        Alamofire.request(.POST, serverURL, parameters: parameters, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    completionHandler(nil);
                    let data = JSON(response.result.value!)
                    self.saveToken(data["data"]["token"].stringValue, validityDate: data["data"]["validityDate"].stringValue);
                
                case .Failure(let error):
                    completionHandler(error);
                    print("HTTP RESPONSE: \n\(error.localizedDescription)");
                }
        }
        return;
    }
    
    /*
    Save the tokens into the app edit username
    */
    func saveToken(token: String, validityDate: String) {
        print("Save token");
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;

        // Check if there's an existing token
        let data = getToken()
        
        if data.count > 0 {
            // There's an existing token, overwrite it
            let request = NSFetchRequest(entityName: "Token");
            let entityDescription = NSEntityDescription.entityForName("Token", inManagedObjectContext: context);
            request.entity = entityDescription;
            
           
            do {
                let result: NSArray = try context.executeFetchRequest(request);
                let existingToken = result[0] as! NSManagedObject;

                existingToken.setValue(token, forKey: "token");
                existingToken.setValue(validityDate, forKey: "validityDate");
                
                try existingToken.managedObjectContext?.save();
                print("Token updated");
            } catch let error as NSError {
                print("Could not save token \(error) ---- \(error.userInfo)");
            }
            
        } else {
            // No tokens, create new entry
            let newToken = NSEntityDescription.insertNewObjectForEntityForName("Token", inManagedObjectContext: context);
            newToken.setValue(token, forKey: "token");
            newToken.setValue(validityDate, forKey: "validityDate");
            
            do {
                try context.save();
                print("Token saved");
            } catch let error as NSError {
                print("Could not save \(error), \(error.localizedDescription)");
            }
        }
        
        return;
    }
    
    /*
    Retrieves token inside the core data
    */
    func getToken() -> Dictionary<String,String> {
        // Variable that will hold the token to be returned
        var data = [String:String]();

        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        let request = NSFetchRequest(entityName: "Token");
        let entityDescription = NSEntityDescription.entityForName("Token", inManagedObjectContext: context);
        request.entity = entityDescription;
    
        do {
            let result: NSArray = try context.executeFetchRequest(request);

            if result.count > 0 {
                let token = result[0] as! NSManagedObject;
                data["token"] = (token.valueForKey("token") as! String);
                data["validityDate"] = (token.valueForKey("validityDate") as! String);
            }
            print("Get Token done.");
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }
        return data;
    }
    
    /*
    Used to delete the tokens in the core data
    */
    func logout() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        let request = NSFetchRequest(entityName: "Token");
        
        do {
            let fetched = try context.executeFetchRequest(request);
            
            for item in fetched {
                context.deleteObject(item as! NSManagedObject);
            }
            try context.save()
            
            print("Logged out");
            
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)");
        }
    }
    
    /*
    (For debugging purposes)
    Display the token in the device
    */
    private func displayToken() {
        // Variable that will hold the token to be returned
        
        print("DISPLAYING ALL STORED TOKENS:");
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        let request = NSFetchRequest(entityName: "Token");
        let entityDescription = NSEntityDescription.entityForName("Token", inManagedObjectContext: context);
        
        request.entity = entityDescription;
        
        do {
            let result: NSArray = try context.executeFetchRequest(request);
            let tokens = result as! [NSManagedObject];
            for token in tokens {
                print("token:\(token.valueForKey("token")!)\n");
                print("validityDate:\(token.valueForKey("validityDate")!)\n");
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }
    }
    
    

    
    
}

