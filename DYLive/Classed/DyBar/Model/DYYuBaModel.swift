//
//  DYYuBaModel.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/6.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
@objcMembers
class DYYuBaImglist: NSObject {
    var url:String?
    var thumb_url:String?
    var size:[String:AnyObject]?
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

@objcMembers
class DYYuBaSubcomments: NSObject {
    var nick_name:String?
    var content:String?
    var likes:Int = 0
    
    init(dict:[String:AnyObject]) {
        super.init()
        self.nick_name = dict["nick_name"] as? String
        self.content = dict["content"] as? String
        self.likes = dict["likes"] as! Int
//        setValuesForKeys(dict)
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {
        
    }
    
}

@objcMembers
class DYYuBaModel: NSObject {

    /***
    "feed_id":1131739162026712082,
    "feed_id_str":1131739162026712082,
    "uid":35617227,
    "nick_name":"旭旭姥姥6868",
    "own_group_id":3295268,
    "own_group_name":"旭旭姥姥6868",
    "avatar":"https://apic.douyucdn.cn/upload/avatar_v3/201811/a91ddc17f20ea650f98dcb872e46bcf3_big.jpg",
    "sex":2,
    "dy_level":47,
    "is_followed":0,
    "type":1,
    "sub_type":1,
    "relate_id":553823491551793378,
    "content":"[呲牙]",
    "imglist":[
    {
    "url":"https://img.douyucdn.cn/data/yuba/weibo/2019/03/05/201903052142483830318987296.png?i=3390a95305661b561f391aada92e4f4193",
    "thumb_url":"https://img.douyucdn.cn/data/yuba/weibo/2019/03/05/201903052142483830318987296.500x500.png?i=3390a95305661b561f391aada92e4f4193",
    "size":{
    "h":419,
    "w":390
    }
    }
    ],
    "video":[
    
    ],
    "source_id":0,
    "source_id_str":"0",
    "comments":206,
    "total_comments":230,
    "likes":475,
    "reposts":6,
    "views":14817,
    "created_at":"8分钟前",
    "is_liked":false,
    "is_favorited":false,
    "share_url":"https://yuba.douyu.com/p/553823491551793378",
    "is_top":0,
    "is_deleted":0,
    "post":{
    "post_id":553823491551793378,
    "post_id_str":553823491551793378,
    "title":"好看的帽子",
    "content":"[呲牙]",
    "group_id":3270215,
    "group_name":"旭旭宝宝",
    "group_type":2,
    "level":0,
    "level_title":"",
    "level_medal":"",
    "imglist":[
    {
    "url":"https://img.douyucdn.cn/data/yuba/weibo/2019/03/05/201903052142483830318987296.png?i=3390a95305661b561f391aada92e4f4193",
    "thumb_url":"https://img.douyucdn.cn/data/yuba/weibo/2019/03/05/201903052142483830318987296.500x500.png?i=3390a95305661b561f391aada92e4f4193",
    "size":{
    "h":419,
    "w":390
    }
    }
    ],
    "video":[
    
    ],
    "is_vote":false,
    "source":0,
    "vote":[
    
    ],
    "is_digest":0,
    "last_reply_time":"",
    "digest_time":""
    },
    "prize":{
    
    },
    "sub_comments":[
    Object{...},
    Object{...}
    ],
    "manager_type":0,
    "vote":[
    
    ],
    "dist":"",
    "account_type":0,
    "account_comments":"",
    "medals":null,
    "anchor_oper":0,
    "embed_part":null,
    "safe_uid":"6N7n2WjpY7bl"
    },
     */
    
    
    var cellHeight :CGFloat = 0
    var avatar:String?
    var nick_name:String?
    var sex:Int = 1
    var dy_level:Int = 1
    var created_at:String?
    var views:NSNumber?
    var title:String?
    var content:String?
    var imglist:[DYYuBaImglist]?
    var sub_comments:[DYYuBaSubcomments]?
    var group_name:String?
    var total_comments:Int = 230
    var likes:Int = 475
    var reposts:Int = 6
    
    init(dict:[String:AnyObject]) {
        super.init()
        setValuesForKeys(dict)
        
        let post = dict["post"] as? [String:AnyObject]
        self.title = post?["title"] as? String
        self.content = post?["content"] as? String
        
        let imglist = post?["imglist"] as? [[String:AnyObject]]
        var list = [DYYuBaImglist]()
        for value in imglist!{
            let model = DYYuBaImglist(dict:value)
            list.append(model)
        }
        self.imglist = list
        self.group_name = post?["group_name"] as? String
        
        var comments = [DYYuBaSubcomments]()
        let subComments = dict["sub_comments"] as? [[String:AnyObject]]
        for value in subComments!{
            let model = DYYuBaSubcomments(dict:value)
            comments.append(model)
        }
        self.sub_comments = comments
        
    }
    
    override func setValue(_ value: Any?, forUndefinedKey key: String) {

    }
}
