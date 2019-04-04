//
//  DYFollowsVideoModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
@objcMembers
class DYFollowsVideoModel: NSObject {
    var nickname :String?
    var owner_avatar :String?
    var video_str_duration :String?
    var video_title :String?
    var cate2_name :String?
    var video_cover :String?
    var view_num :NSNumber?
    var video_up_num :NSNumber?
    var video_collect_num :NSNumber?
    var comment_num :NSNumber?
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
}
