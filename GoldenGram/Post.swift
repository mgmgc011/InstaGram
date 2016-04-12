//
//  Post.swift
//  GoldenGram
//
//  Created by Kyle on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit



class Post: NSObject {

    var username = String()
    var userID = String()
    var comments = String()
    var likes = Int()
    var photo = String()

    init(dictionary: NSDictionary) {
        //come back and make sure keys are consistent
        username = dictionary.objectForKey("username") as! String
        userID = dictionary.objectForKey("userID") as! String
        comments = dictionary.objectForKey("comments") as! String
        likes = dictionary.objectForKey("likes") as! Int
        photo = dictionary.objectForKey("photo") as! String
    }

}
