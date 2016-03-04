//
//  SignUpViewController.swift
//  doharmony
//
//  Created by eliakim on 2/19/16.
//  Copyright © 2016 Eleazer Toluan. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class SignUpViewController: UIViewController {
    
    @IBOutlet var FirstnameTextField: UITextField!
    @IBOutlet var LastnameTextField: UITextField!
    @IBOutlet var EmailTextField: UITextField!
    @IBOutlet var UsernameTextField: UITextField!
    @IBOutlet var PasswordTextField: UITextField!
    @IBOutlet var RetypePasswordTextField: UITextField!
    
    @IBOutlet weak var firstnameLabel: UILabel!
    @IBOutlet weak var lastnameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var usernameLabel: UILabel!
    @IBOutlet weak var passwordLabel: UILabel!
    @IBOutlet weak var retypePasswordLabel: UILabel!
    
    let validator = Validator();
    let serverURL = "http://192.168.0.137:8080/api/users";
    
    @IBAction func CancelButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    @IBAction func CloseButton(sender: AnyObject) {
        self.dismissViewControllerAnimated(false, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad();

        // Error messages
        let invalidEmail = "Invalid email";
        let invalidLength = "Minimum of 6 characters";
        let invalidNameLength = "This field is required";
        let alphaNum = "Special characters not allowed";
        
        // Constraints
        let nameMinLength = 1;
        let minLength = 6;
        let maxLength = 24;
        let alphaNumRegex = "^[a-zA-Z0-9\\s]*$"; // spaces allowed
        let usernameRegex = "^[a-zA-Z0-9_.]*$" // no spaces allowed
        
        // Register fields to the validator
        // First name
        validator.addField(Field(view: self.FirstnameTextField, viewLabel: firstnameLabel, errorMessage: alphaNum, validationRule: ValidationRule.Format(alphaNumRegex)));
        validator.addField(Field(view: self.FirstnameTextField, viewLabel: firstnameLabel,errorMessage: invalidNameLength, validationRule: ValidationRule.Length(.In, nameMinLength...maxLength as ClosedInterval)));
        // Last name
        validator.addField(Field(view: self.LastnameTextField, viewLabel: lastnameLabel, errorMessage: alphaNum, validationRule: ValidationRule.Format(alphaNumRegex)));
        validator.addField(Field(view: self.PasswordTextField, viewLabel: lastnameLabel, errorMessage: invalidNameLength, validationRule: ValidationRule.Length(.In, nameMinLength...maxLength as ClosedInterval)));
        // Email
        validator.addField(Field(view: self.EmailTextField, viewLabel: emailLabel,errorMessage: invalidEmail, validationRule: ValidationRule.Email));
        // Username
        validator.addField(Field(view: self.UsernameTextField, viewLabel: usernameLabel, errorMessage: invalidLength, validationRule: ValidationRule.Length(.Minimum, minLength)));
        validator.addField(Field(view: self.UsernameTextField, viewLabel: usernameLabel, errorMessage: alphaNum, validationRule: ValidationRule.Format(usernameRegex)));
        // Password
        validator.addField(Field(view: self.PasswordTextField, viewLabel: passwordLabel,errorMessage: invalidLength, validationRule: ValidationRule.Length(.In, minLength...maxLength as ClosedInterval)));
        validator.addField(Field(view: self.PasswordTextField, viewLabel: passwordLabel, errorMessage: alphaNum, validationRule: ValidationRule.Format(alphaNumRegex)));
        // Retype Password
        validator.addField(Field(view:self.RetypePasswordTextField, viewLabel: retypePasswordLabel,errorMessage: invalidLength, validationRule: ValidationRule.Length(.In, minLength...maxLength as ClosedInterval)));
        validator.addField(Field(view: self.RetypePasswordTextField, viewLabel: passwordLabel, errorMessage: alphaNum, validationRule: ValidationRule.Format(alphaNumRegex)));
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func signupTapped(sender: UIButton) {
        
        if PasswordTextField.text != RetypePasswordTextField.text {
            passwordLabel.text = "Passwords do not match";
            retypePasswordLabel.text = "Passwords do not match";
        }
        
        // Validate the fields
        let fields = validator.allErrors();
        
        if fields.count > 0 {
            // There are validation errors, show error messages
            
            for field in fields {
                field.viewLabel.text = field.errorMessage;
            }
            
        } else {
            // All inputs are valid
            
            print("No validation errors --- Proceeding to sending signup request");
            let auth = Auth(); // Create an auth object for saving the token
            
            // Set the text field values as parameters for the signup request
            let parameters = [
                "first_name" : FirstnameTextField.text!,
                "last_name" : LastnameTextField.text!,
                "email" : EmailTextField.text!,
                "username" : UsernameTextField.text!,
                "password" : PasswordTextField.text!
            ];
            
            Alamofire.request(.POST, self.serverURL, parameters: parameters, encoding: .JSON)
                .validate()
                .responseJSON { response in
                    switch response.result {
                    case .Success:
                        let data = JSON(response.result.value!);
                        auth.saveToken(data["data"]["token"].stringValue, validityDate: data["data"]["validityDate"].stringValue);
                        // Redirection code to somewhere here
                        print(data);
                    case .Failure(let error):
                        print("HTTP RESPONSE:\n\(error.localizedDescription)");
                    }
            }
        }

    }
    // Attach each of these to their corresponding textfields' `Did change`
    @IBAction func validateFirstName(sender: UITextField) {
        self.firstnameLabel.text = validator.hasError(sender)?.result();
    }

    @IBAction func validateLastname(sender: UITextField) {
        self.lastnameLabel.text = validator.hasError(sender)?.result();
    }
    
    @IBAction func validateEmail(sender: UITextField) {
        self.emailLabel.text = validator.hasError(sender)?.result();
    }
    
    @IBAction func validateUsername(sender: UITextField) {
        self.usernameLabel.text = validator.hasError(sender)?.result();
    }
    
    @IBAction func validatePassword(sender: UITextField) {
        self.passwordLabel.text = validator.hasError(sender)?.result();
    }
    
    @IBAction func validateRetypePassword(sender: UITextField) {
        self.retypePasswordLabel.text = validator.hasError(sender)?.result();
    }
        
}
