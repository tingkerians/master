//
//  SignUpViewController.swift
//  doharmony
//
//  Created by eliakim on 2/19/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class SignUpViewController: UIViewController {
    
    @IBOutlet var FirstnameTextField: UITextField!
    @IBOutlet var LastnameTextField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var UsernameTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var RetypePasswordTextField: UITextField!
    
    @IBAction func CancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    @IBAction func CloseButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func signupTapped(sender: AnyObject) {
        //
        
    }
    

}
