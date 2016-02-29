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
    let serverURL = "http://192.168.0.137:8080/api/login";
    
    /*
    Checks if the current user has an existing token saved on the device
    returns `true` if there's an existing token
    */
    func isLoggedIn() -> Bool{
        let data = getToken();
        
        if let _ = data["token"] {
            return true;
        } else {
            return false;
        }
    }
    
    /*
    Send a login request to the server with parameters `username` and `password`
    */
    func login(username: String, password: String) {
        let parameters = [
            "username" : username,
            "password" : password
        ];
        
        Alamofire.request(.POST, serverURL, parameters: parameters, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let data = JSON(response.result.value!)
                    self.saveToken(parameters["username"]!, token: data["token"].stringValue);
                    
                case .Failure(let error):
                    print("HTTP RESPONSE: \n\(error.localizedDescription)");
//                    self.showAlert("Login failed", message: String(error.localizedDescription));
                }
        }
        return;
    }
    
    /*
    Save the tokens into the app
    */
    func saveToken(username: String, token: String) {
        print("Save token");
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        // Check if there's an existing token
        let data = getToken()
        
        if data.count > 0 {
            // There's an existing token, overwrite it
            let request = NSFetchRequest(entityName: "Users");
            let entityDescription = NSEntityDescription.entityForName("Users", inManagedObjectContext: context);
            request.entity = entityDescription;
            
            do {
                let result: NSArray = try context.executeFetchRequest(request);
                let user = result[0] as! NSManagedObject;
                user.setValue(username, forKey: "username");
                user.setValue(token, forKey: "token");
                
                try user.managedObjectContext?.save();
                print("updated token");
            } catch let error as NSError {
                print("Could not fetch \(error), \(error.userInfo)");
            }

        } else {
            // No duplicates, create new entry
            let newToken = NSEntityDescription.insertNewObjectForEntityForName("Users", inManagedObjectContext: context);
            newToken.setValue(username, forKey: "username");
            newToken.setValue(token, forKey: "token");
            
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
    private func getToken() -> Dictionary<String,String> {
        // Variable that will hold the token to be returned
        var data = [String:String]();

        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        let request = NSFetchRequest(entityName: "Users");
        let entityDescription = NSEntityDescription.entityForName("Users", inManagedObjectContext: context);
        request.entity = entityDescription;
    
        do {
            let result: NSArray = try context.executeFetchRequest(request);

            if result.count > 0 {
                let user = result[0] as! NSManagedObject;
                data["username"] = (user.valueForKey("username") as! String);
                data["token"] = (user.valueForKey("token") as! String);
            }
            print("Get Token done.");
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }
        return data;
    }

    /*
    (For debugging purposes)
    Displays all token per user that is stored in the device
    */
    private func displayToken() {
        // Variable that will hold the token to be returned
        
        print("DISPLAYING ALL STORED TOKENS:");
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        
        let request = NSFetchRequest(entityName: "Users");
        let entityDescription = NSEntityDescription.entityForName("Users", inManagedObjectContext: context);
        
        request.entity = entityDescription;
        // uncomment if searching for a specific token
//        request.predicate = NSPredicate(format: "username = %@", username);
        
        do {
            let result: NSArray = try context.executeFetchRequest(request);
            let user = result as! [NSManagedObject];
            for u in user {
                print("username:\(u.valueForKey("username")!)");
                print("token:\(u.valueForKey("token")!)\n");
            }
            
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)");
        }
    }
    
    
    /*
    (For logout function)
    Used to delete the contents of the coreData
    */
    func unsetToken() {
        let appDel: AppDelegate = (UIApplication.sharedApplication().delegate as! AppDelegate);
        let context: NSManagedObjectContext = appDel.managedObjectContext;
        let request = NSFetchRequest(entityName: "Users");
        
        do {
            let fetched = try context.executeFetchRequest(request);

            for item in fetched {
                context.deleteObject(item as! NSManagedObject);
            }
            
            print("`Users` core data deleted");
            
        } catch let error as NSError {
            print("Could not delete \(error), \(error.userInfo)");
        }
    }

    /*
    SAMPLE FUNCTION
    Sends a request to the server together with an invalid token
    */
    func getTracks() {
        var token = String();
        let localData = getToken();
        let url = "http://192.168.0.137:8080/api/getJSONTracks"
        if localData.count > 0 {
            print("Existing token: \(localData)");
            token = localData["token"]!;
        } else {
            return;
        }
        
        let parameters = [
            "token" : token
        ];
        
        Alamofire.request(.POST, url, parameters: parameters, encoding: .JSON)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let data = JSON(response.result.value!)
                    print(data);
                    
                case .Failure(let error):
                    var errorMessage = String();
                    
                    if let data = response.data {
                        let responseJSON = JSON(data: data)
                        
                        if let responseToken: String = responseJSON["token"].stringValue {
                            if !responseToken.isEmpty {
                                errorMessage = "Invalid token";
                                // Replace the current token with the new token sent by the server
                                self.saveToken(localData["username"]!, token: responseToken);
                            } else {
                                errorMessage = error.localizedDescription;
                            }
                        }
                    }

//                    print("HTTP RESPONSE: \n\(error.localizedDescription)");
                    print("HTTP RESPONSE: \(error.localizedDescription)");
                }
        }
        return;
    }

    func renewToken() {
        
    }
    
}