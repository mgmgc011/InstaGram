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
        
//        var fullname = fullNameLabel.text
        CURRENT_USER.observeEventType(.Value) { (snapshot) in
            print(snapshot.value)
        }
//        fullname = CURRENT_USER.authData.valueForKey("first_name") as? String
//        fullname == CURRENT_USER.valueForKey("first_name") as? String
//        print(CURRENT_USER.valueForKey("first_name_"))

    }

    

}
