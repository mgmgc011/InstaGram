//
//  ViewController.swift
//  GoldenGram
//
//  Created by Mingu Chu on 4/8/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Create a reference to a Firebase location
        let myRootRef = Firebase(url:"https://torrid-heat-209.firebaseio.com")
        // Write data to Firebase
        myRootRef.setValue("Do you have data? You'll love Firebase.")

    }
}