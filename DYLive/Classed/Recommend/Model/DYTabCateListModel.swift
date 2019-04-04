//
//  DYTabCateListModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/2.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
@objcMembers
class DYTabCateListModel: NSObject {

    var cate_id:NSInteger?
    var level:NSInteger?
    var tab_id:NSInteger?
    var cate_name:String?
    var push_nearby:String?
    var short_name:String?
    var push_vertical_screen:String?
    var push_ios:String?
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
