//
//  RotationViewController.swift
//  UIImageTransformsDemo
//
//  Created by Rafal Bereski on 30.01.2016.
//  Copyright © 2016 Rafał Bereski. All rights reserved.
//

import UIKit

class RotationViewController: UIViewController {
    @IBOutlet weak var imageView: UIImageView!
    var originalImage: UIImage?
    var rotationAngle: CGFloat = 0
    let rotationStep: CGFloat = 10

    @IBAction func didTapSelectImage(_ sender: AnyObject) {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = UIImagePickerControllerSourceType.photoLibrary
        imagePicker.delegate = self
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func didTapRotateLeft(_ sender: AnyObject) {
        rotationAngle = (360 + rotationAngle - rotationStep).truncatingRemainder(dividingBy: 360)
        self.imageView.image = originalImage?.rotate(angle: degreesToRadians(degrees: rotationAngle))
        print("rotate: \(rotationAngle)")
    }
    
    @IBAction func didTapRotateRight(_ sender: AnyObject) {
        rotationAngle = (rotationAngle + rotationStep).truncatingRemainder(dividingBy: 360)
        self.imageView.image = originalImage?.rotate(angle: degreesToRadians(degrees: rotationAngle))
        print("rotate: \(rotationAngle)")
    }
    
    func degreesToRadians(degrees: CGFloat) -> CGFloat {
        return degrees / CGFloat(180.0) * CGFloat.pi
    }
}


extension RotationViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        self.dismiss(animated: true) {
            guard let image = info[UIImagePickerControllerOriginalImage] as? UIImage else { return }
            self.originalImage = image
            self.imageView.image = image
            self.rotationAngle = 0
        }
    }
}
