//
//  DownloadViewController.swift
//  GoldenGram
//
//  Created by Kyle on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase

class DownloadViewController: UIViewController {

    @IBOutlet weak var downloadImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

 
    }


    @IBAction func downloadButtonTapped(sender: UIButton) {
        let ref = Firebase(url:"https://torrid-heat-209.firebaseio.com")
        
        ref.observeEventType(.Value, withBlock: { snapshot in
        
        let encodedImageData = snapshot.value as! String
            
            
            let imageData = NSData(base64EncodedString: encodedImageData, options: [] )
        let image = UIImage(data: imageData!)
            self.downloadImageView.image = image
            })
        
        
    }
    
    

}
