//
//  DYRecommendCateListViewModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/2.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

class DYRecommendCateListViewModel: NSObject {
    lazy var cateListData:[DYTabCateListModel] = [DYTabCateListModel]()
}

extension DYRecommendCateListViewModel{
    func requestData(_ completionHandler: @escaping ()->())  {
        let tabCate_url = "https://apiv2.douyucdn.cn/live/Cate/getTabCate1List?client_sys=ios"
        let session = URLSession.shared
        let url = URL(string:tabCate_url)
        let dataTask:URLSessionDataTask = session.dataTask(with: url!) { (data, response, error) in
            if((error) != nil){
                print("error ========= \(String(describing: error)) ")
            }else{
                let json :[String:Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                let data :[[String:Any]] = json["data"] as! [[String : Any]]
                var temp = [DYTabCateListModel]()
                for dict in data{
                    let model = DYTabCateListModel(dict: dict)
                    temp.append(model)
                }
                self.cateListData = temp
                completionHandler()
            }
        }
        dataTask.resume()
    }
}
