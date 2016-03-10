//
//  protectedPage.swift
//  doharmony
//
//  Created by khemer d great on 09/03/2016.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//
import UIKit
class UIViewControllerProtectedPage: UIViewController {
    
    var auth:Auth!
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        auth = Auth.sharedInstance
        if(auth.isUserLoggedIn == false){
            goToLogoutPage()
        }
    }
    
    func goToLogoutPage(){
        // User is not logged in(guest), redirect to login page
        let vc = LoginViewController(nibName: "LoginViewController", bundle: nil);
        self.navigationController?.pushViewController(vc, animated: true);
        self.presentViewController(vc, animated: true, completion: nil);
        
    }
    
}

struct tabBarTransition{
    static var selectedIndex: Int?
    static var prevSelectedIndex: Int = 0
    static var rootController: UITabBarController?
}