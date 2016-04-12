//
//  CreateUserViewController.swift
//  GoldenGram
//
//  Created by Mingu Chu on 4/11/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase

class CreateUserViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var confirmPasswordField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var firstNameField: UITextField!
    @IBOutlet weak var lastNameField: UITextField!
    @IBOutlet weak var dateOfBirthField: UITextField!
    var currentUserRef = Firebase()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func createAcoountButton(sender: UIButton) {
        
        let email = emailField.text
        let password = passwordField.text
        let confirmpassword = confirmPasswordField.text
        let username = userNameField.text
        let firstname = firstNameField.text
        let lastname = lastNameField.text
        let dob = dateOfBirthField.text
        
        if email != "" && password == confirmpassword && username != "" && firstname != "" && lastname != "" && dob != "" {
            FIREBASE_REF.createUser(email, password: password, withValueCompletionBlock: { (error, authData) -> Void in
                if error == nil {
                    FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) -> Void in
                        if error == nil {
                            NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                            let userDictionary = ["first_name": firstname! as String, "last_name": lastname! as String, "user_name": username! as String, "date_of_birth": dob! as String]
                            let userRef = FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String)
                            userRef.setValue(userDictionary)
                            print("Account Created")
                            self.dismissViewControllerAnimated(true, completion: nil)
                        } else {
                            print(error)
                        }
                    })
                } else {
                    print(error)
                }
            })
        } else {
            let alert = UIAlertController(title: "Please enter all required info", message: nil, preferredStyle: .Alert)
            let action = UIAlertAction(title: "Okay", style: .Default , handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
        
    

    
}
}
