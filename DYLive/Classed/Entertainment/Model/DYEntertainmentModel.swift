//
//  DYEntertainmentModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/2.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
@objcMembers
class DYEntertainmentModel: NSObject {
    var room_name:String?
    var room_src:String?
    var nickname:String?
    var online_num:NSNumber?
    var anchor_label:[[String:Any]]?
    
    override init() {
        super.init()
    }
    
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }

    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        return "roomName: \(room_name ?? ""), roomSrc: \(room_src ?? ""), nickname: \(nickname ?? ""), hn: \(online_num ?? 10) anchor_label:\(anchor_label)"
    }
}
