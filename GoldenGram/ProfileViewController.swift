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
    
    var posts = [Post]()
    @IBOutlet weak var profileCollectionView: UICollectionView!
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        profileCollectionView.delegate = self
        profileCollectionView.dataSource = self
        FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: {(snapshot) in
            let first = snapshot.value.objectForKey("first_name") as! String
            let last = snapshot.value.objectForKey("last_name") as! String
            self.fullNameLabel.text = "\(first) \(last)"
            self.dateOfBirthLabel.text = snapshot.value.objectForKey("date_of_birth") as? String
            
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
        return posts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CellID", forIndexPath: indexPath) as! ProfileCollectionViewCell

        FIREBASE_REF.childByAppendingPath("users").childByAppendingPath(NSUserDefaults.standardUserDefaults().valueForKey("uid") as! String).observeEventType(.Value, withBlock: {(snapshot) in

            var image = snapshot.value.objectForKey("image")
            let post = self.posts[indexPath.row]
            image = self.conversion(post.photo)
            cell.imageView.image = image as? UIImage

        })
        return cell

    }
    
    func conversion(post: String) -> UIImage {
        let imageData = NSData(base64EncodedString: post, options: [] )
        let image = UIImage(data: imageData!)
        return image!
    }
    
    
    
}
