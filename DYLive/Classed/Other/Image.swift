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
    
      func circleImage() -> UIImage {
        //开始图形上下文
        UIGraphicsBeginImageContextWithOptions(self.size, false, UIScreen.main.scale)
        //获取图形上下文
        let contentRef:CGContext = UIGraphicsGetCurrentContext()!
        //设置圆形
        let rect = CGRect(x: 0, y: 0, width: self.size.width, height: self.size.height)
        //根据 rect 创建一个椭圆
        contentRef.addEllipse(in: rect)
        //裁剪
        contentRef.clip()
        //将原图片画到图形上下文
        self.draw(in:rect)
        //从上下文获取裁剪后的图片
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        //关闭上下文
        UIGraphicsEndImageContext()
        return newImage
    }
}
