//
//  Bundle.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import Foundation
import UIKit
extension Bundle{
    var namespace : String {
        return   infoDictionary?["CFBundleName"] as? String ?? ""
    }
}

extension CGRect{
    static func make(_ x:CGFloat,_ y:CGFloat, _ width:CGFloat, _ height:CGFloat) -> CGRect{
        return CGRect(x:x, y:y, width:width, height:height)
    }
}

extension UIColor{
    static func random_color() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
    }
    
}
