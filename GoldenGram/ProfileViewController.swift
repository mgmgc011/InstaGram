//
//  ProfileViewController.swift
//  GoldenGram
//
//  Created by Mingu Chu on 4/11/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase

class ProfileViewController: UIViewController {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: {(snapshot) in
            //            print(snapshot.value)
            //            print(snapshot.value.objectForKey("first_name"))
            let first = snapshot.value.objectForKey("first_name") as! String
            let last = snapshot.value.objectForKey("last_name") as! String
            self.fullNameLabel.text = "\(first) \(last)"
        })
        
        
    }
    
    @IBAction func logOutButton(sender: UIButton) {
        if NSUserDefaults.standardUserDefaults().valueForKey("uid") != nil {
            FIREBASE_REF.unauth()
            NSUserDefaults.standardUserDefaults().setValue(nil, forKey: "uid")
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateInitialViewController()
            presentViewController(vc!, animated: true, completion: nil)
        } else {
            print("error")
        }
    }
    
    
}
