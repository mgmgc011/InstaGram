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
    
    var posts: [Post]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (posts?.count)!
    }

    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("PostID", forIndexPath: indexPath) as! PostCollectionViewCell
        let post = posts![indexPath.row];
//        cell.postImageView.image = UIImage(post.photo
        cell.userButton.titleLabel?.text = post.username
        cell.likesButton.titleLabel!.text = String(format: "Likes: %i", post.likes)
        cell.commentsTextView.text = post.comments
        // use post.userID to segue to right profileViewController
        return cell
        
    }

}
