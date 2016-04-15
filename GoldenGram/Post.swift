//
//  Post.swift
//  GoldenGram
//
//  Created by Kyle on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase



class Post: NSObject {

//    var username = String()
    var userID = String()
    var comments = [String]()
    var likes = Int()
    var photo = String()
    var username = String()

    init(snapshot: FDataSnapshot) {
        
        
        username = snapshot.value.objectForKey("user_name") as! String
        userID = snapshot.value.objectForKey("userID") as! String
        comments = snapshot.value.objectForKey("comments") as! [String]
        likes = snapshot.value.objectForKey("likes") as! Int
        photo = snapshot.value.objectForKey("image") as! String
    }

}
