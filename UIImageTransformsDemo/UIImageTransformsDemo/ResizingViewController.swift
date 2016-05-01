//
//  ResizingViewController.swift
//  UIImageTransformsDemo
//
//  Created by Rafal Bereski on 30.01.2016.
//  Copyright © 2016 Rafał Bereski. All rights reserved.
//

import UIKit


class ResizingViewController: UIViewController
{
    @IBOutlet weak var originalImageView: UIImageView!
    @IBOutlet weak var resizedImageView1: UIImageView!
    @IBOutlet weak var resizedImageView2: UIImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func didTapSelectImage(sender: UIButton) {
        let imagePicker = UIImagePickerController()
        
        imagePicker.sourceType = .PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
}


extension ResizingViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true) {
            self.originalImageView.image = image
            let size1 = self.resizedImageView1.bounds.size * 2
            let size2 = self.resizedImageView2.bounds.size * 2
            self.resizedImageView1.image = image.resize(size: size1)
            self.resizedImageView2.image = image.resize(size: size2)
        }
    }
}