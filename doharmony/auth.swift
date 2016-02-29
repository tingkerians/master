//
//  auth.swift
//  doharmony
//
//  Created by khemer d great on 23/02/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import Foundation

class auth{
    init(){
        
    }
    
    func login(username: String, password: String){
    
//        
//        let serverURL = "http://192.168.0.138:8080/users/login";
//        
//        if (username.isEmpty || password.isEmpty) {
//            let message = "Username and password should not be empty";
//            self.showAlert("Alert", message: message);
//            return;
//        }
//        
//        let parameters = [
//            "username" : username,
//            "password" : password
//        ];
//        
//        
//        Alamofire.request(.POST, serverURL	, parameters: parameters, encoding: .JSON)
//            .validate()
//            .responseJSON { response in
//                switch response.result {
//                case .Success:
//                    let result = JSON(response.result.value!);
//                    self.saveToken(parameters["username"]!, token: result["token"].stringValue);
//                    let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
//                    let vc: UIViewController = storyboard.instantiateViewControllerWithIdentifier("RevealViewController") as UIViewController
//                    self.presentViewController(vc, animated: true, completion: nil)
//                    
//                case .Failure(let error):
//                    print("HTTP RESPONSE: \n\(response.response)"); //
//                    print("STATUS CODE:\(response.response?.statusCode)");
//                    self.showAlert("Login failed", message: String(error.localizedDescription));
//                }
//        }
    }
}
