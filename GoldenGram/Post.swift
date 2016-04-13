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
//    private var _postDescription: String!
//    private var _imageUrl: String?
//    private var _postKey: String!
//    
//    var postDescription: String {
//        return _postDescription
//    }
//    
//    var imageUrl: String? {
//        return _imageUrl
//    }
//    
//    
//    
//    init(description: String, imageUrl: String?) {
//        self._postDescription = description
//        self._imageUrl = imageUrl
//    }
//    
//    init(postKey: String, dictionary: Dictionary<String, AnyObject>) {
//        self._postKey = postKey
//        
//        if let imgUrl = dictionary["imageUrl"] as? String {
//            self._imageUrl = imgUrl
//        }
//        
//        if let desc = dictionary["description"] as? String {
//            self._postDescription = desc
//        }
//    }
}
