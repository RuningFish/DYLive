//
//  DYRecommendBaseModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/4.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYRecommendBaseModel: NSObject {
    var vertical_src :String = ""
    var room_name :String = ""
    var nickname :String = ""
    var game_name :String = ""
    var online :NSNumber?

    init(dict:[String:Any]) {
        super.init()
        self.vertical_src = dict["vertical_src"] as! String
        self.room_name = dict["room_name"] as! String
        self.nickname = dict["nickname"] as! String
        self.game_name = dict["game_name"] as! String
        self.online = dict["online"] as? NSNumber
    }
}
