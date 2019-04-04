//
//  DYFollowsVideoHeaderModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
@objcMembers
class DYFollowsVideoHeaderModel: NSObject {
    var icon :String?
    var contents :String?
    var nickName :String?
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
