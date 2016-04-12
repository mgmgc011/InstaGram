//
//  PhotoUploadViewController.swift
//  GoldenGram
//
//  Created by Kyle on 4/12/16.
//  Copyright © 2016 Mingu Chu. All rights reserved.
//

import UIKit
import CoreImage

class PhotoUploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITableViewDataSource, UITableViewDelegate {

    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var camera: UIButton!
    @IBOutlet weak var photoLibrary: UIButton!
    
    //FILTER NAMES AND TYPES
    var items: [String] = ["None", "Tonality", "Noir", "Ansel Adams", "Dark","Dots", "Sepia", "Fade", "Chrome", "Process", "Transfer", "Instant","Color Invert"]
    
    var filterNames: [String] = ["CIColorControls", "CIPhotoEffectTonal","CIPhotoEffectNoir","CIMaximumComponent","CIMinimumComponent","CIDotScreen", "CISepiaTone", "CIPhotoEffectFade", "CIPhotoEffectChrome", "CIPhotoEffectProcess", "CIPhotoEffectTransfer", "CIPhotoEffectInstant", "CIColorInvert"]
    
    
    var originalImage : UIImage = UIImage(named:"flower.jpg")!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    
    //ACCESS PHOTO LIBRARY
    @IBAction func photoLibraryButtonTapped(sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .PhotoLibrary
        
        presentViewController(picker, animated: true, completion: nil)
        
    }
    
    //ACCESS CAMERA
    @IBAction func cameraButtonTapped(sender: UIButton) {
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType = .Camera
        
        presentViewController(picker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        imageView.image = info[UIImagePickerControllerOriginalImage] as? UIImage;
        originalImage = imageView.image!
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    
    
    
    //LIST OF FILTERS IN TABLE
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell = UITableViewCell(style: UITableViewCellStyle.Subtitle,
                                                    reuseIdentifier: "filterCell")
        
        cell.textLabel!.text = items[indexPath.row]
        
        
        return cell
    }
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let CIfilterName = filterNames[indexPath.row]
        print(CIfilterName)
        
        let ciContext = CIContext(options: nil)
        let startImage = CIImage(image: originalImage)
        
        let filter = CIFilter(name: CIfilterName)
        filter!.setDefaults()
        
        filter!.setValue(startImage, forKey: kCIInputImageKey)
        let filteredImageData = filter!.valueForKey(kCIOutputImageKey) as! CIImage
        let filteredImageRef = ciContext.createCGImage(filteredImageData, fromRect: filteredImageData.extent)
        
        imageView.image = UIImage(CGImage: filteredImageRef);
        
    }

    @IBAction func uploadPhotoTapped(sender: UIButton) {
        
    }
    
    
    
    
    
    
}