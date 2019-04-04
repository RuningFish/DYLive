//
//  DYFollowsViewModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/2.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

class DYFollowsViewModel: NSObject {
    lazy var data:[[DYFollowsModel]] = [[DYFollowsModel]]()
    lazy var videoList:[[DYFollowsVideoModel]] = [[DYFollowsVideoModel]]()
    lazy var videoHeaderUp:[DYFollowsVideoHeaderModel] = [DYFollowsVideoHeaderModel]()
}

extension DYFollowsViewModel{
    func requestData(_ completionHandler: @escaping ()->())  {
        let path :String? = Bundle.main.path(forResource: "follows", ofType: ".plist")
        let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
        let data = dict!["data"] as! [[String:AnyObject]]
        var temp = [DYFollowsModel]()
        for dic in data{
            let model = DYFollowsModel(dict: dic)
            temp.append(model)
        }
        self.data.append(temp)
        completionHandler()
    }
    
    func changeModel(model:DYFollowsModel) -> DYRecommendNormal {
        let recommendM = DYRecommendNormal()
        recommendM.room_name = model.roomName!
        recommendM.vertical_src = model.roomSrc!
        recommendM.online = model.hn as NSNumber?
        recommendM.nickname = model.nickname!
        return recommendM
    }
    
    func getVideoList(_ completionHandler:@escaping ()->()) {
        let url = "https://apiv2.douyucdn.cn/video/recom/getFwRecomVodList?client_sys=ios"
        HttpTool.getRequest(url: url, completionHandler: { (result) in
            let data = result["data"] as! [[String:Any]]
            var temp = [DYFollowsVideoModel]()
            for dic in data{
                let video = DYFollowsVideoModel(dict: dic)
                temp.append(video)
            }
            self.videoList.append(temp)
            completionHandler()
        }) { (err) in
            
        }
    }
    
    func getVideoHeaderList(_ completionHandler:@escaping ()->()) {
        let path :String? = Bundle.main.path(forResource: "FollowsVideoUp", ofType: ".plist")
        let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
        let data = dict!["data"] as! [String:Any]
        let list = data["list"] as! [[String:Any]]
        var temp = [DYFollowsVideoHeaderModel]()
        for dic in list{
            let model = DYFollowsVideoHeaderModel(dict: dic)
            temp.append(model)
        }
        videoHeaderUp = temp
        completionHandler()
    }
}
