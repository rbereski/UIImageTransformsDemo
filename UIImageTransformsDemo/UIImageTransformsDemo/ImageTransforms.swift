//
//  ImageTransforms.swift
//  UIImageTransformsDemo
//
//  Created by Rafal Bereski on 30.01.2016.
//  Copyright © 2016 Rafał Bereski. All rights reserved.
//

import UIKit


extension UIImage {
    fileprivate func createBitmapContext(width: Int, height: Int) -> CGContext {
        let image = self.cgImage!
        let bitsPerComponent = image.bitsPerComponent
        let colorSpace = image.colorSpace
        let bitmapInfo = image.bitmapInfo.rawValue
        let ctx = CGContext(data: nil, width: width, height: height,
            bitsPerComponent: bitsPerComponent, bytesPerRow: 0,
            space: colorSpace!, bitmapInfo: bitmapInfo)
        return ctx!
    }
}


extension UIImage {
    // Resizing without keeping aspect ratio of the original image
    func resize(size newSize: CGSize) -> UIImage {
        let ctx = createBitmapContext(width: Int(newSize.width), height: Int(newSize.height))
        
        let dstRect = CGRect(origin: CGPoint.zero, size: newSize)
        ctx.draw(self.cgImage!, in: dstRect)
        
        let resizedImage = UIImage(cgImage: ctx.makeImage()!)
        return resizedImage
    }
    
    
    // Resizing with keeping aspect ratio of the original image
    func resizeWithAspectFill(size newSize : CGSize) -> UIImage {
        let ctx = createBitmapContext(width: Int(newSize.width), height: Int(newSize.height))
        let originalAspectRatio = size.width/size.height
        let newAspectRatio = newSize.width/newSize.height
        
        let scaleFactor = originalAspectRatio < newAspectRatio
            ? newSize.width/size.width : newSize.height/size.height
        
        ctx.translateBy(x: newSize.width/2, y: newSize.height/2)
        ctx.scaleBy(x: scaleFactor, y: scaleFactor)
        
        let dstRect = CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height)
        ctx.draw(self.cgImage!, in: dstRect)
        
        let resizedImage = UIImage(cgImage: ctx.makeImage()!)
        return resizedImage
    }
    

    // Rotation
    func rotate(angle : CGFloat) -> UIImage {
        // New size after rotation multiplied by UIImage scale
        let newWidth: CGFloat = abs(size.width * cos(angle)) + abs(size.height * sin(angle)) * self.scale
        let newHeight: CGFloat = abs(size.width * sin(angle)) + abs(size.height * cos(angle)) * self.scale
        
        let ctx = createBitmapContext(width: Int(newWidth), height: Int(newHeight))
        
        // Setup transformation matrix
        ctx.translateBy(x: newWidth/2, y: newHeight/2)
        ctx.rotate(by: -angle)

        // Draw original image in the center of the new bitmap
        let dstRect = CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height)
        ctx.draw(self.cgImage!, in: dstRect)
        
        let rotatedImage = UIImage(cgImage: ctx.makeImage()!)
        return rotatedImage
    }
}


func * (l : CGSize, r: CGFloat) -> CGSize {
    return CGSize(width: l.width * r, height: l.height * r)
}
