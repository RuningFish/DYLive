//
//  DYDiscoverViewModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

class DYDiscoverViewModel: DYBaseViewModel {
    var yuyinGroup: DYAnchorGroup = DYAnchorGroup()
    var videoGroup: DYAnchorGroup = DYAnchorGroup()
    var activityGroup: DYAnchorGroup = DYAnchorGroup()
}

extension DYDiscoverViewModel{
    func requestData(_ completionHandler: @escaping ()->()){
       let group = DispatchGroup()
        group.enter()
        let yuyinUrl = "https://apiv2.douyucdn.cn/gv2api/rkc/roomlist/1_18/0/4/ios?client_sys=ios"
        HttpTool.getRequest(url: yuyinUrl, completionHandler: { (result) in
            let data = result["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            self.getYuyin(list)
            group.leave()
        }) { (error) in
            let path :String? = Bundle.main.path(forResource: "DiscoverYuyin", ofType: ".plist")
            let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
            let data = dict!["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            self.getYuyin(list)
            group.leave()
        }
        
        group.enter()
        let videoUrl = "https://apiv2.douyucdn.cn/video/home/getRecVideoList1?limit=4&client_sys=ios"
        HttpTool.getRequest(url: videoUrl, completionHandler: { (result) in
            let data = result["data"] as! [[String:Any]]
            self.getVideo(data)
            group.leave()
        }) { (error) in
            let path :String? = Bundle.main.path(forResource: "DiscoverVideo", ofType: ".plist")
            let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
            let data = dict!["data"] as! [[String:Any]]
            self.getVideo(data)
            group.leave()
        }
        
        group.enter()
        let activityUrl = "https://apiv2.douyucdn.cn/live/Home/getHomeActive?limit=15&client_sys=ios&offset=0"
        HttpTool.getRequest(url: activityUrl, completionHandler: { (result) in
            let data = result["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            self.getActivity(list)
            group.leave()
        }) { (error) in
            let path :String? = Bundle.main.path(forResource: "DiscoverActivity", ofType: ".plist")
            let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
            let data = dict!["data"] as! [String:Any]
            let list = data["list"] as! [[String:Any]]
            self.getActivity(list)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main){
            self.baseGroup.insert(self.activityGroup, at: 0)
            self.baseGroup.insert(self.videoGroup, at: 0)
            self.baseGroup.insert(self.yuyinGroup, at: 0)
            completionHandler()
        }
    }
    
    func getYuyin(_ list:[[String:Any]]) {
        for dic in list{
            let model = DYRecommendNormal()
            model.vertical_src = dic["vertical_src"] as! String
            model.room_name = dic["room_name"] as! String
            model.nickname = dic["nickname"] as! String
            model.game_name = dic["cate2_name"] as! String
            model.online = (dic["hn"] as! NSNumber)
            self.yuyinGroup.list.append(model)
        }
        self.yuyinGroup.tag_name = "语音直播"
    }
    
    func getVideo(_ data:[[String:Any]]) {
        for dic in data{
            let model = DYRecommendNormal()
            model.vertical_src = dic["video_cover"] as! String
            model.game_name = ""//dic["room_name"] as! String
            model.nickname = dic["nickname"] as! String
            model.room_name = dic["video_title"] as! String
            model.online = 0//(dic["hn"] as! NSNumber)
            self.videoGroup.list.append(model)
        }
        self.videoGroup.tag_name = "热门视频"
    }
    
    func getActivity(_ data:[[String:Any]]) {
        for dic in data{
            let model = DYRecommendBaseModel()
            model.act_pic = dic["act_pic"] as! String
            if dic["act_link"] is String{
                model.act_link = dic["act_link"] as! String
            }else if dic["act_link"] is NSNumber{
                let num: NSNumber = dic["act_link"] as! NSNumber
                let formattor = NumberFormatter()
                formattor.numberStyle = .decimal
                model.act_link = formattor.string(from: num) ?? ""
            }
            self.activityGroup.list.append(model)
        }
            self.activityGroup.tag_name = "活动"
    }
}
