//
//  LoginViewController.swift
//  doharmony
//
//  Created by eliakim on 2/19/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController, UITextFieldDelegate {
    
    @IBAction func cancelButton(sender: AnyObject) {
        tabBarTransition.rootController?.selectedIndex = tabBarTransition.prevSelectedIndex
         self.dismissViewControllerAnimated(false, completion: nil)
    }

    @IBAction func SignUpButton(sender: AnyObject) {
        let vc = SignUpViewController(nibName: "SignUpViewController", bundle: nil)
        self.navigationController?.pushViewController(vc, animated: true)
        self.presentViewController(vc, animated: true, completion: nil)
    }
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var UsernameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        UsernameTextField.delegate = self
        PasswordTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillShow:"), name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: Selector("keyboardWillHide:"), name: UIKeyboardWillHideNotification, object: nil)
        let tapGesture = UITapGestureRecognizer(target: self, action: "tap:")
        view.addGestureRecognizer(tapGesture)
//         Do any additional setup after loading the view.
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func keyboardWillShow(sender: NSNotification) {
//        self.view.frame.origin.y -= 150
    }
    func keyboardWillHide(sender: NSNotification) {
//        self.view.frame.origin.y += 150
    }
    func textFieldShouldReturn(commentTextfield: UITextField) -> Bool {
        print("return keyboard")
        UsernameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
        return true
    }
    func tap(gesture: UITapGestureRecognizer){
        UsernameTextField.resignFirstResponder()
        PasswordTextField.resignFirstResponder()
    }
    
    @IBAction func loginTapped(sender: AnyObject) {
        let username = UsernameTextField.text!;
        let password = PasswordTextField.text!;
        
        let auth = Auth.sharedInstance;
        auth.login(username, password: password) { error in
            // If the login is a success
            if (error == nil) {
                self.dismissViewControllerAnimated(false, completion: nil)
            } else { // There's an error
                // Show an alert or something similar here and display the `error` message.
                print("Has errors --- Login failed");
            }
        }
        
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
