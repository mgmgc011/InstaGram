//
//  BaseService.swift
//  GoldenGram
//
//  Created by Mingu Chu on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import Foundation
import Firebase

let BASE_URL = "golengram.firebaseIO.com"
let FIREBASE_REF = Firebase(url: BASE_URL)
var CURRENT_USER: Firebase {
    let userID = NSUserDefaults.standardUserDefaults().valueForKey("uid") as? String
    let currentUser = Firebase(url: "\(FIREBASE_REF) ").childByAppendingPath("users").childByAppendingPath(userID)
    return currentUser
}
