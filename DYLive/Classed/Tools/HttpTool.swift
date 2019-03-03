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
//case options = "OPTIONS"
//case get     = "GET"
//case head    = "HEAD"
//case post    = "POST"
//case put     = "PUT"
//case patch   = "PATCH"
//case delete  = "DELETE"
//case trace   = "TRACE"
//case connect = "CONNECT"
class HttpTool {
    
   class func manager(method:RequestMethod, url:String, param:[String:Any],completion:@escaping (_ result : Any)->()){
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
                print(response.result.error)
                return
            }
            completion(result)
        }
        }
}
