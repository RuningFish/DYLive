//
//  DYFollowsModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/2.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
@objcMembers
class DYFollowsModel: NSObject {
    var roomName:String?
    var roomSrc:String?
    var nickname:String?
    var hn:NSNumber?
    init(dict:[String:Any]) {
        super.init()
        setValuesForKeys(dict)
    }
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
    override var description: String{
        return "roomName: \(roomName ?? ""), roomSrc: \(roomSrc ?? ""), nickname: \(nickname ?? ""), hn: \(hn ?? 10)"
    }
}
