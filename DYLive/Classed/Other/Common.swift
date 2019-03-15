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


let Helvetica_Bold :String = "Helvetica-Bold"
let PingFangSC_Light :String = "PingFangSC-Light"
// 鱼吧内容的左间距
let KContentLeftMargin :CGFloat = 20.0
/*******************************  Notification  ***************************************/
// 推荐页内容滚动通知
let KRecommendContentScrollNotification = "KRecommendContentScrollNotification"

let KStream_url = "rtmp://192.168.99.176:1935/rtmplive/room"
/*******************************  ------------  ***************************************/
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
    
    static func colorWithRGB(r:Int,g:Int,b:Int) -> UIColor{
        return colorWithRGB(r: r, g: g, b: b, l: 1.0)
    }
    
    static func colorWithRGB(r:Int,g:Int,b:Int,l:CGFloat) -> UIColor{
        return UIColor(red: CGFloat(r)/255.0, green: CGFloat(g)/255.0, blue: CGFloat(b)/255.0, alpha: l)
    }
    
}


extension NotificationCenter{
    class func xsyAddobserver(_ observer: Any, selector:Selector, postName:String, object: Any?){
        NotificationCenter.default.addObserver(observer, selector: selector, name:NSNotification.Name(rawValue: postName) , object:object)
    }
    
    class func xsyPostNotification(postName:String, object: Any?) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: postName), object: object)
    }
    
    class func xsyRemoveNotification(_ observer: Any, name:String, object: Any?) {
        NotificationCenter.default.removeObserver(observer, name: NSNotification.Name(rawValue: name), object: object)
    }
}


extension String {
    func xsy_widthForComment(fontSize: CGFloat, height: CGFloat = 15) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: height), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.width)
    }
    
    func xsy_heightForComment(fontSize: CGFloat, width: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)
    }
    
    func xsy_heightForComment(fontSize: CGFloat, width: CGFloat, maxHeight: CGFloat) -> CGFloat {
        let font = UIFont.systemFont(ofSize: fontSize)
        let rect = NSString(string: self).boundingRect(with: CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .usesLineFragmentOrigin, attributes: [NSAttributedStringKey.font: font], context: nil)
        return ceil(rect.height)>maxHeight ? maxHeight : ceil(rect.height)
    }
}

//MARK: -定义button相对label的位置
enum XSYButtonEdgeInsetsStyle {
    case Top
    case Left
    case Right
    case Bottom
}

extension UIButton {
    
    func layoutButton(style: XSYButtonEdgeInsetsStyle, imageTitleSpace: CGFloat) {
        //得到imageView和titleLabel的宽高
        let imageWidth = self.imageView?.frame.size.width
        let imageHeight = self.imageView?.frame.size.height
        
        var labelWidth: CGFloat! = 0.0
        var labelHeight: CGFloat! = 0.0
        let version = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as! String
        
        if Double(version)! >= Double(8.0) {
            labelWidth = self.titleLabel?.intrinsicContentSize.width
            labelHeight = self.titleLabel?.intrinsicContentSize.height
        }else{
            labelWidth = self.titleLabel?.frame.size.width
            labelHeight = self.titleLabel?.frame.size.height
        }
        
        //初始化imageEdgeInsets和labelEdgeInsets
        var imageEdgeInsets = UIEdgeInsets.zero
        var labelEdgeInsets = UIEdgeInsets.zero
        
        //根据style和space得到imageEdgeInsets和labelEdgeInsets的值
        switch style {
        case .Top:
            //上 左 下 右
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight-imageTitleSpace/2, 0, 0, -labelWidth)
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth!, -imageHeight!-imageTitleSpace/2, 0)
            break;
            
        case .Left:
            imageEdgeInsets = UIEdgeInsetsMake(0, -imageTitleSpace/2, 0, imageTitleSpace)
            labelEdgeInsets = UIEdgeInsetsMake(0, imageTitleSpace/2, 0, -imageTitleSpace/2)
            break;
            
        case .Bottom:
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight!-imageTitleSpace/2, -labelWidth)
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight!-imageTitleSpace/2, -imageWidth!, 0, 0)
            break;
            
        case .Right:
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth+imageTitleSpace/2, 0, -labelWidth-imageTitleSpace/2)
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWidth!-imageTitleSpace/2, 0, imageWidth!+imageTitleSpace/2)
            break;
            
        }
        
        self.titleEdgeInsets = labelEdgeInsets
        self.imageEdgeInsets = imageEdgeInsets
    }
}
