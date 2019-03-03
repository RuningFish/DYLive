//
//  Bundle.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import Foundation
import UIKit

// 屏幕的宽
let KScreenWidth = UIScreen.main.bounds.size.width
// 屏幕的高
let KScreenHeight = UIScreen.main.bounds.size.height
//状态栏高度 全面屏44 非全面屏20
let KStatusBarHeight = UIApplication.shared.statusBarFrame.height;
//导航栏高度
let KNavigationHeight : CGFloat = (KStatusBarHeight + 44)
//tabbar高度
let KTabBarHeight : CGFloat = (KStatusBarHeight == 44 ?83:49)
//顶部的安全距离
let KTopSafeAreaHeight : CGFloat = (KStatusBarHeight - 20)
//底部的安全距离
let KBottomSafeAreaHeight : CGFloat = (KTabBarHeight - 49)
// 推荐页推荐条高度
let KPageTitleHeight : CGFloat = 44

extension Bundle{
    var namespace : String {
        return   infoDictionary?["CFBundleName"] as? String ?? ""
    }
    
    static var DYResourceBundle : Bundle {
        let url = Bundle.main.url(forResource: "DYResource", withExtension: "bundle")
        guard let uri = url else{ return Bundle()}
        return Bundle(url:uri) ?? Bundle()
    }
}

extension CGRect{
    static func make(_ x:CGFloat,_ y:CGFloat, _ width:CGFloat, _ height:CGFloat) -> CGRect{
        return CGRect(x:x, y:y, width:width, height:height)
    }
}

extension NSDate{
    class func getCurrentTime() -> String {
        return "\(NSDate().timeIntervalSince1970)"
    }
}

extension UIColor{
    static func random_color() -> UIColor {
        return UIColor(red: CGFloat(arc4random()%256)/255.0, green: CGFloat(arc4random()%256)/255.0, blue: CGFloat(arc4random()%256)/255.0, alpha: 1)
    }
    
}
