//
//  DYBaseTool.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/4.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

class DYBaseTool: NSObject {
   static func getLevelIcon(_ level:Int = 1) -> String {
        var imgUrl = ""
        let path :String? = Bundle.main.path(forResource: "LevelIcon", ofType: ".plist")
        let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
        let data = dict!["data"] as! [String:AnyObject]
        let pre = data["urlPre"] as! String
        let icon = data["icon"] as! [String:Any]
        let imgL = (level>120 ? icon["120"]:icon["\(level)"]) as! String
        imgUrl = "\(pre)\(imgL)"
        return imgUrl
    }
}
