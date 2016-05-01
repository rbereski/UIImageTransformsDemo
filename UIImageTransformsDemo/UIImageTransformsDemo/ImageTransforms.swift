//
//  ImageTransforms.swift
//  UIImageTransformsDemo
//
//  Created by Rafal Bereski on 30.01.2016.
//  Copyright © 2016 Rafał Bereski. All rights reserved.
//

import UIKit


extension UIImage
{
    // Resizing without keeping aspect ratio of the original image
    func resize(size newSize: CGSize) -> UIImage {
        let ctx = createBitmapContext(width: Int(newSize.width), height: Int(newSize.height))
        CGContextDrawImage(ctx, CGRect(origin: CGPointZero, size: newSize), self.CGImage!)
        let resizedImage = UIImage(CGImage: CGBitmapContextCreateImage(ctx)!)
        return resizedImage
    }
    
    
    private func createBitmapContext(width width: Int, height: Int) -> CGContext {
        let image = self.CGImage!
        let bitsPerComponent = CGImageGetBitsPerComponent(image)
        let colorSpace = CGImageGetColorSpace(image)
        let bitmapInfo = CGImageGetBitmapInfo(image).rawValue
        let ctx = CGBitmapContextCreate(nil, width, height, bitsPerComponent, 0, colorSpace, bitmapInfo)
        return ctx!
    }
    
    
    // Resizing with keeping aspect ratio of the original image
    func resizeWithAspectFill(size newSize : CGSize) -> UIImage {
        let ctx = createBitmapContext(width: Int(newSize.width), height: Int(newSize.height))
        let originalAspectRatio = size.width/size.height
        let newAspectRatio = newSize.width/newSize.height
        
        let scaleFactor = originalAspectRatio < newAspectRatio ? newSize.width/size.width : newSize.height/size.height
        CGContextTranslateCTM(ctx, newSize.width/2, newSize.height/2)
        CGContextScaleCTM(ctx, scaleFactor, scaleFactor)
        
        let dstRect = CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height)
        CGContextDrawImage(ctx, dstRect, self.CGImage!)
        
        let resizedImage = UIImage(CGImage: CGBitmapContextCreateImage(ctx)!)
        return resizedImage
    }
    

    // Rotation
    func rotate(angle : CGFloat) -> UIImage {
        // New size after rotation multiplied by UIImage scale
        let newWidth: CGFloat = abs(size.width * cos(angle)) + abs(size.height * sin(angle)) * self.scale
        let newHeight: CGFloat = abs(size.width * sin(angle)) + abs(size.height * cos(angle)) * self.scale
        
        let ctx = createBitmapContext(width: Int(newWidth), height: Int(newHeight))
        
        // Setup transformation matrix
        CGContextTranslateCTM(ctx, newWidth/2, newHeight/2)
        CGContextRotateCTM(ctx, -angle)
        
        // Draw original image in the center of the new bitmap
        let dstRect = CGRect(x: -size.width/2, y: -size.height/2, width: size.width, height: size.height)
        CGContextDrawImage(ctx, dstRect, self.CGImage!)
        
        let rotatedImage = UIImage(CGImage: CGBitmapContextCreateImage(ctx)!)
        return rotatedImage
    }
}


func * (l : CGSize, r: CGFloat) -> CGSize {
    return CGSize(width: l.width * r, height: l.height * r)
}
