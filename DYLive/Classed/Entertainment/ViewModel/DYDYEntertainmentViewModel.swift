//
//  DYDYEntertainmentViewModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/2.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

class DYDYEntertainmentViewModel: NSObject {
    lazy var group:[[DYEntertainmentModel]] = [[DYEntertainmentModel]]()
    lazy var data:[DYEntertainmentModel] = [DYEntertainmentModel]()
}

extension DYDYEntertainmentViewModel{
    func requestData(_ completionHandler: @escaping ()->())  {
        let url = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/2_124/0/20/ios?client_sys=ios"
        HttpTool.getRequest(url: url, completionHandler: { (result) in
            let data = result["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            self.enumList(list)
            completionHandler()
        }) { (error) in
            let path :String? = Bundle.main.path(forResource: "Entertainment", ofType: ".plist")
            let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
            let data = dict!["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            self.enumList(list)
            completionHandler()
        }

    }
    
    func enumList(_ list:[[String:Any]]) {
        for dic in list {
            let model = DYEntertainmentModel(dict: dic)
            self.data.append(model)
        }
        self.group.removeAll()
        self.group.append(self.data)
    }
    
    func changeModel(model:DYEntertainmentModel) -> DYRecommendNormal {
        let recommendM = DYRecommendNormal()
        recommendM.room_name = model.room_name!
        recommendM.vertical_src = model.room_src!
        recommendM.online = model.online_num!
        recommendM.nickname = model.nickname!
        return recommendM
    }
}

