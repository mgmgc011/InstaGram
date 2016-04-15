//
//  User.swift
//  GoldenGram
//
//  Created by Dylan Bruschi on 4/14/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit

class User: NSObject {
    var firstName = String()
    var lastName = String()
    var username = String()
    var userID = String()
    
    init(dict: NSDictionary) {
        
        
        username = dict.objectForKey("user_name") as! String
        firstName = dict.objectForKey("first_name") as! String
        lastName = dict.objectForKey("last_name") as! String
        userID = dict.objectForKey("userID") as! String

        
    }

}
