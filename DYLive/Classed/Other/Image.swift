//
//  Image.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import Foundation
import UIKit

extension UIImage{
   static func imageWithOriginal(_ name:String) -> UIImage {
        var image = UIImage(named:name)
        image = image?.withRenderingMode(UIImageRenderingMode.alwaysOriginal)
        return image!
    }
    
    static func imageWithColor(color: UIColor) -> UIImage{
        return imageWithColor(color: color, viewSize: CGSize(width:1,height:1))
    }
    
    static func imageWithColor(color: UIColor, viewSize: CGSize) -> UIImage{
        let rect: CGRect = CGRect(x: 0, y: 0, width: viewSize.width, height: viewSize.height)
        UIGraphicsBeginImageContext(rect.size)
        let context: CGContext = UIGraphicsGetCurrentContext()!
        context.setFillColor(color.cgColor)
        context.fill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsGetCurrentContext()
        return image!
    }
}
