//
//  ViewController.swift
//  GoldenGram
//
//  Created by Mingu Chu on 4/8/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {
    @IBOutlet weak var userNameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        print(CURRENT_USER)

    }
    @IBAction func logInButtonTapped(sender: UIButton) {
        let email = self.userNameField.text
        let password = self.passwordField.text
        
        if email != "" && password != "" {
            FIREBASE_REF.authUser(email, password: password, withCompletionBlock: { (error, authData) in
                if error == nil {
                    NSUserDefaults.standardUserDefaults().setValue(authData.uid, forKey: "uid")
                    print ("logged in")
                    self.performSegueWithIdentifier("logInSegue", sender: self)
                    
                } else {
                    let alert = UIAlertController(title: "Incorrect email or password", message: "try again", preferredStyle: .Alert)
                    let action = UIAlertAction(title: "Cancel", style: .Default , handler: nil)
                    alert.addAction(action)
                    self.presentViewController(alert, animated: true, completion: nil)
                    print(error)
                }
            })
        } else {
            let alert = UIAlertController(title: "Incorrect email or password", message: "try again", preferredStyle: .Alert)
            let action = UIAlertAction(title: "Cancel", style: .Default , handler: nil)
            alert.addAction(action)
            presentViewController(alert, animated: true, completion: nil)
        }
        
        
//        let ref = Firebase(url: "https://golengram.firebaseio.com")
//        ref.authUser(userNameField.text, password: passwordField.text) { (error, authData) in
//            if error != nil {
//                print("incorrect")
//            } else {
//                
//            }
//        }
    }
    
}