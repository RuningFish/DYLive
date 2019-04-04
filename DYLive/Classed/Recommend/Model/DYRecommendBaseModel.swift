//
//  DYRecommendBaseModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/4.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
@objcMembers
class DYRecommendBaseModel: NSObject {
    var vertical_src :String = ""
    var room_name :String = ""
    var nickname :String = ""
    var game_name :String = ""
    var online :NSNumber?
    var act_pic :String = ""
    var act_link:String = ""
    override init() {
        super.init()
    }
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
