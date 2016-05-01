//
//  RotationViewController.swift
//  UIImageTransformsDemo
//
//  Created by Rafal Bereski on 30.01.2016.
//  Copyright © 2016 Rafał Bereski. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController
{
    @IBOutlet weak var imageView: UIImageView!
    var originalImage: UIImage?
    var rotationAngle: CGFloat = 0
    let rotationStep: CGFloat = 10
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
    @IBAction func didTapSelectImage(sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary
        imagePicker.delegate = self
        self.presentViewController(imagePicker, animated: true, completion: nil)
    }
    
    
    @IBAction func didTapRotateLeft(sender: AnyObject) {
        rotationAngle = (360 + rotationAngle - rotationStep) % 360
        self.imageView.image = originalImage?.rotate(degreesToRadians(rotationAngle))
        print("rotate: \(rotationAngle)")
    }
    
    
    @IBAction func didTapRotateRight(sender: AnyObject) {
        rotationAngle = (rotationAngle + rotationStep) % 360
        self.imageView.image = originalImage?.rotate(degreesToRadians(rotationAngle))
        print("rotate: \(rotationAngle)")
    }
    
    
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees / CGFloat(180.0) * CGFloat(M_PI)
    }
}


extension RotationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate
{
    func imagePickerController(picker: UIImagePickerController,
        didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
        self.dismissViewControllerAnimated(true) {
            self.originalImage = image
            self.imageView.image = image
            self.rotationAngle = 0
        }
    }
}