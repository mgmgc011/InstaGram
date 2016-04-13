//
//  FeedViewController.swift
//  GoldenGram
//
//  Created by Kyle on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit

class FeedViewController: UIViewController, UICollectionViewDataSource, UICollectionViewDelegate {
    
    @IBOutlet weak var feedCollectionView: UICollectionView!
    
    var posts = [Post]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print(NSUserDefaults.standardUserDefaults())
        let userPostRef = FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).childByAppendingPath("userPosts")
        
        
        userPostRef.observeEventType(.Value, withBlock: { snapshot1 in
            let postArray = snapshot1.value.allValues as? [String]
            if postArray != nil {
                for address: String in postArray! {
                    let postRef = FIREBASE_REF.childByAppendingPath("posts").childByAppendingPath(address)
                    postRef.observeEventType(.Value, withBlock: { snapshot2 in
                        let aPost = Post.init(snapshot: snapshot2)
                        print(aPost)
                        self.posts.append(aPost)
                        if self.posts.count == postArray!.count {
                            dispatch_async(dispatch_get_main_queue()) {
                                self.feedCollectionView.reloadData()
                            }
                        }
                    })
                }
            }
        })
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PostID", forIndexPath: indexPath) as! PostCollectionViewCell
        let post = posts[indexPath.row];
        cell.postImageView.image = coversion(post.photo)
        cell.userButton.setTitle(post.username, forState: .Normal)
        cell.userButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left
        cell.likesButton.setTitle("Likes: \(post.likes)", forState: .Normal)
        cell.likesButton.contentHorizontalAlignment = UIControlContentHorizontalAlignment.Left

//        cell.likesButton.titleLabel!.text = String(format: "Likes: %i", post.likes)
        //        cell.commentsTextView.text = post.comments as [String]
        return cell
        
    }
    func coversion(post: String) -> UIImage {
        let imageData = NSData(base64EncodedString: post, options: [] )
        let image = UIImage(data: imageData!)
        //        self.downloadImageView.image = image
        return image!
    }
    
    
    
}
