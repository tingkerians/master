//
//  MyProfileViewController.swift
//  doharmony
//
//  Created by Eleazer Toluan on 2/11/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class MyProfileViewController: UIViewController{
    
    
    @IBOutlet weak var followingLabel: UILabel!
    @IBOutlet weak var friendsLabel: UILabel!
    @IBOutlet weak var followersLabel: UILabel!
    @IBOutlet weak var userVideosLabel: UILabel!
    @IBOutlet weak var fullnameLabel: UILabel!
    @IBOutlet weak var ProfilePicture: UIImageView! //
    
    // Variable that will hold user's token
    let auth = Auth();
    let userToken = String();
    var userProfileData = [String:JSON]();
    let serverURL = "http://192.168.0.137:8080/api/users";
    
    @IBAction func LogoutButton(sender: AnyObject) {
        
        auth.logout();
        
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
//        auth.logout() // delete this
        
        ProfilePicture.layer.cornerRadius = ProfilePicture.frame.width / 2
        
    }
    
    override func viewDidAppear(animated: Bool) {
        
        if auth.isUserLoggedIn() {
            print("Token found -- User logged in");
            
            self.fetchProfileData { error in
                error == nil ? print("wala") : print("wala din");
                if error == nil {
                    // Fetch success
                    self.updateProfilePage();
                } else {
                    print("Fail --- Error on fetching user data");
                }
            }
        
            
        } else {
            print("Token not found --- User is a `Guest`");
            
            // User is not logged in(guest), redirect to login page
            let vc = LoginViewController(nibName: "LoginViewController", bundle: nil);
            self.navigationController?.pushViewController(vc, animated: true);
            self.presentViewController(vc, animated: true, completion: nil);
        }
    }
    
    /**
     Fetching user profile data from the server
     
     edit: since alamofire makes asynchronous requests,
        a `completionHandler` is needed to be called once the
        fetching of data has completed
     
     Usage:
     fetchProfileData() { error in
         if error == nil { // there are no errors
             // code...
         } else { // there are errors
             // code here to display `error` variable i.e.
             print(error.localizedDescription);
         }
     }
     
     */
    func fetchProfileData(completionHandler: (NSError?) -> Void) {
        print("Fetching --- User data");

        let token = auth.getToken();
        let parameters = [
            "token" : token["token"]!
        ];

        // Fetch profile data
        Alamofire.request(.GET, serverURL, parameters: parameters)
            .validate()
            .responseJSON { response in
                switch response.result {
                case .Success:
                    let data = JSON(response.result.value!);
                    self.userProfileData = data["data"].dictionaryValue;
                    completionHandler(nil);
                case .Failure (let error):
                    print("HTTP RESPONSE: \n\(error.localizedDescription)");
                    completionHandler(error);
                }
        }
    }
    
    /**
     Update the details and image on the user profile page
     */
    func updateProfilePage() {
        fullnameLabel.text = self.userProfileData["name"]!.stringValue;
        friendsLabel.text = self.userProfileData["friends"]!.stringValue;
        userVideosLabel.text = self.userProfileData["videos"]!.stringValue;
        followersLabel.text = self.userProfileData["followers"]!.stringValue;
        followingLabel.text = self.userProfileData["following"]!.stringValue;
    
        let profPic: String = "http://192.168.0.137:8080/api/photo/\(self.userProfileData["id"]!.stringValue)";
        ProfilePicture.image = UIImage(data: NSData(contentsOfURL: NSURL(string: profPic)!)!);
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// Extension for getting minutes between 2 dates
extension NSDate {
    func minutesFrom(date:NSDate) -> Int{
        return NSCalendar.currentCalendar().components(.Minute, fromDate: date, toDate: self, options: []).minute
    }
}

// Extension for converting a string into a date
extension String {
    func stringToDate() -> NSDate {
        let formatter = NSDateFormatter();
        formatter.locale = NSLocale(localeIdentifier: "US_en");
        formatter.dateFormat = "yyyy-MM-dd, HH:mm:ss Z";
        let date = formatter.dateFromString(self);
        return date!;
    }
}
