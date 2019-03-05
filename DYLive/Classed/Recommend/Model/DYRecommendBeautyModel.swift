//
//  DYRecommendBeautyModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/4.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYRecommendBeautyModel: DYRecommendBaseModel {
    var anchor_city : String = ""
    override init(dict:[String : Any]) {
        super.init(dict:dict)
        self.anchor_city = (dict["anchor_city"] as? String)!
    }
}
