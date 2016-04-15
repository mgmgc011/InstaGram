//
//  PostCollectionViewCell.swift
//  GoldenGram
//
//  Created by Kyle on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit



protocol LikeAddedDelegate {
    func likeAdded (cell: PostCollectionViewCell)
}


let imageHeight: CGFloat = 200.0
let offSetSpeed: CGFloat = 50.0

class PostCollectionViewCell: UICollectionViewCell, UITextFieldDelegate {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    var image: UIImage = UIImage() {
        didSet {
            postImageView.image = image
        }
    }
    
    func offset(offset: CGPoint) {
        postImageView.frame = CGRectOffset(self.postImageView.bounds, offset .x, offset .y)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    @IBOutlet weak var userButton: UIButton!
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var likesButton: UIButton!
    @IBOutlet weak var commentTextField: UITextField!
    
    
    var likeDelegate: LikeAddedDelegate?
    
    
    @IBAction func likeButtonTapped(sender: UIButton) {
        
        likeDelegate.self?.likeAdded(self)
        
        print("tapped")
    }
    
}
