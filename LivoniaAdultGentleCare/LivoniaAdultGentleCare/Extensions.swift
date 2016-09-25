//
//  Extensions.swift
//  LivoniaAdultGentleCare
//
//  Created by Ovidiu Bortas on 9/24/16.
//  Copyright © 2016 Ovidiu Bortas. All rights reserved.
//

import UIKit

//extension UIImage {
//    func imageWith(color: UIColor) -> UIImage {
//        UIGraphicsBeginImageContextWithOptions(self.size, false, self.scale)
//        
//        let context = UIGraphicsGetCurrentContext()! as CGContext
//        context.translateBy(x: 0, y: self.size.height)
//        context.scaleBy(x: 1.0, y: -1.0)
//        context.setBlendMode(.normal)
//        //CGContextSetBlendMode(context, kCGBlendModeNormal)
//        
//        let rect = CGRect(x: 0.0, y: 0.0, width: size.width, height: size.height)
//        //let rect = CGRect(0.0, 0.0, size.width, size.height)
//    
//        context.clip(to: rect, mask: self.cgImage!)
//        color.setFill()
//        context.fill(rect)
//        
//        let newImage = UIGraphicsGetImageFromCurrentImageContext()! as UIImage
//        UIGraphicsEndImageContext()
//        
//        return newImage
//    }
//}
