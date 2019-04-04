//
//  HttpTool.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import Alamofire

enum RequestMethod {
    case Get
    case Post
    case Head
    case Delete
}

struct BaseError:Error {
    var desc :String = ""
    var localizedDescription:String{
        return desc
    }
    init(_ desc:String) {
        self.desc = desc
    }
}

class HttpTool {
    
   class func manager(method:RequestMethod, url:String, param:[String:Any]?,completion:@escaping (_ result : Any)->()){
        var httpType : HTTPMethod
        switch method {
            case .Get:
                httpType = HTTPMethod.get
            case .Post:
                httpType = HTTPMethod.post
            case .Head:
                httpType = HTTPMethod.head
            case .Delete:
            httpType = HTTPMethod.delete
        }
    
    Alamofire.request(url, method: httpType, parameters: param, encoding: URLEncoding.default, headers: nil).responseJSON{ (response) in
//            print("------\(response)")
            guard let result = response.result.value else {
//                print(response.result.error)
                return
            }
            completion(result)
        }
        }
    
    class func getRequest(url:String,completionHandler:@escaping (_ result:[String:Any])->(),error:@escaping (_ error:Error)->())  {
        let session = URLSession.shared
        let url = URL(string:url)
        let dataTask:URLSessionDataTask = session.dataTask(with: url!) { (data, response, err) in
            if((err) != nil){
                print("error ========= \(String(describing: error)) ")
                error(err!)
            }else{
                let json :[String:Any] = try! JSONSerialization.jsonObject(with: data!, options: []) as! [String : Any]
                let code:Int = json["error"] as! Int
                if code == 0{
                    completionHandler(json)
                }else {
                    let baseErr = BaseError("\(String(describing: url!)) -- 请求出错")
                    print("baseErr \(baseErr)")
                    error(baseErr)
                }
                
            }
        }
        dataTask.resume()
    }
}
