//
//  ProfileViewController.swift
//  GoldenGram
//
//  Created by Mingu Chu on 4/11/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase


class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var fullNameLabel: UILabel!
    @IBOutlet weak var dateOfBirthLabel: UILabel!
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    var posts = [Post]()
    var images = [UIImage]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: {(snapshot) in
            let first = snapshot.value.objectForKey("first_name") as! String
            let last = snapshot.value.objectForKey("last_name") as! String
            self.fullNameLabel.text = "\(first) \(last)"
            self.dateOfBirthLabel.text = snapshot.value.objectForKey("date_of_birth") as? String
            
        })
        let userPostRef = FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).childByAppendingPath("userPosts")
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
                                self.profileCollectionView.reloadData()
                            }
                        }
                    })
                }
            }
        })
        profileCollectionView.reloadData()
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
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        print(posts.count)
        return posts.count
        
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath) as! ProfileCollectionViewCell
        let post = posts[indexPath.row]
        cell.imageView.image = conversion(post.photo)
        return cell

    }
    
    func conversion(post: String) -> UIImage {
        let imageData = NSData(base64EncodedString: post, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }
    
    
    
}
