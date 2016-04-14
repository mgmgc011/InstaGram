//
//  PostCollectionViewCell.swift
//  GoldenGram
//
//  Created by Kyle on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit

let imageHeight: CGFloat = 300.0
let offSetSpeed: CGFloat = 50.0

class PostCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var postImageView: UIImageView!
    
    var image: UIImage = UIImage() {
        didSet {
            postImageView.image = image
        }
    }
    
    func offset(offset: CGPoint) {
        postImageView.frame = CGRectOffset(self.postImageView.bounds, offset .x, offset .y)
    }
    
    @IBOutlet weak var userButton: UIButton!
    
    @IBOutlet weak var commentsTextView: UITextView!
    @IBOutlet weak var likesButton: UIButton!
    
    
}
