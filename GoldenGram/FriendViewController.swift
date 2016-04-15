//
//  FriendViewController.swift
//  GoldenGram
//
//  Created by Dylan Bruschi on 4/14/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase

class FriendViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    var friendUID: String?
    var posts = [Post]()
    var images = [UIImage]()

    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var dobLabel: UILabel!
    @IBOutlet weak var friendLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(friendUID).observeEventType(.Value, withBlock: {(snapshot) in
            let first = snapshot.value.objectForKey("first_name") as! String
            let last = snapshot.value.objectForKey("last_name") as! String
            self.friendLabel.text = "\(first) \(last)"
            self.dobLabel.text = snapshot.value.objectForKey("date_of_birth") as? String
            
        })
        
        let userPostRef = FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(friendUID).childByAppendingPath("userPosts")
        
        
        userPostRef.observeEventType(.Value, withBlock: { snapshot1 in
            let postArray = snapshot1.value.allValues as? [String]
            if postArray != nil {
                for address: String in postArray! {
                    let postRef = FIREBASE_REF.childByAppendingPath("posts").childByAppendingPath(address)
                    postRef.observeEventType(.Value, withBlock: { snapshot2 in
                        let aPost = Post.init(snapshot: snapshot2)
                        
                        self.posts.append(aPost)
                        if self.posts.count == postArray!.count {
                            dispatch_async(dispatch_get_main_queue()) {
                                self.collectionView.reloadData()
                            }
                        }
                    })
                }
            }
        })
        collectionView.reloadData()
    }


    @IBAction func onBackButtonTapped(sender: AnyObject) {
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let viewcontroller = storyboard.instantiateViewControllerWithIdentifier("TabBarController")
        presentViewController(viewcontroller, animated: true, completion: nil)
    }

    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
        
    }
    

    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath) as! ProfileCollectionViewCell
        let post = posts[indexPath.row]
        cell.friendsImageView.image = conversion(post.photo)
//        cell..image = conversion(post.photo)
        
        
        
        return cell
        
    }
    
    func conversion(post: String) -> UIImage {
        let imageData = NSData(base64EncodedString: post, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }
    
    @IBAction func onFollowButtonTapped(sender: UIButton){
    
    if sender.titleLabel!.text == "Follow" {
        sender.titleLabel!.text = "Followed"
        let friendPostRef = FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(friendUID).childByAppendingPath("userPosts")
          let allPostRef = FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).childByAppendingPath("allPosts")
        
        friendPostRef.observeEventType(.Value, withBlock: { snapshot in
            let postArray = snapshot.value.allValues as? [String]
            if postArray != nil {
    
                for post in postArray! {
                    let aPost = post as String
        allPostRef.updateChildValues([String(format:"Timestamp: %i:", NSInteger(NSDate.timeIntervalSinceReferenceDate())) : aPost])
            }
        

        }
            
        })
        
    
    
    } else {
        let alert = UIAlertController(title: "Hey!", message: "You've already followed this person", preferredStyle: .Alert)
        let action = UIAlertAction(title: "Okay", style: .Default, handler: nil)
        alert.addAction(action)
        presentViewController(alert, animated: true, completion: nil)
    
    }
    


}
    
    func convertPost(post: Post) -> NSDictionary {
        let dict = ["user_name": post.username, "userID": post.userID, "comments": post.comments, "likes": post.likes, "image": post.photo]
        return dict
        
    }
}
