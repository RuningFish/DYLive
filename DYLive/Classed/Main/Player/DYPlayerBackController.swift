//
//  DYPlayerBackController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/15.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import IJKMediaFramework
class DYPlayerBackController: UIViewController {

    private var player :IJKMediaPlayback?
    var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        url = "http://7xlv47.com1.z0.glb.clouddn.com/xxx004.m3u8"
//        url = "http://tc-tct.douyucdn2.cn/dyliveflv1/"
        let live:String = "288016rlols5_2000p.flv?wsAuth=e049f6ce59b60a4c5172045f2b649510\\u0026token=app-ios-0-288016-e9416291174176ee57f96e95b9a1f8b842315f95c3910b0e\\u0026logo=0\\u0026expire=0\\u0026did=4e0eb51fd02bafb072b9e49300001521\\u0026ver=4.600\\u0026pt=1\\u0026st=0\\u0026mix=0"
        
        // 288016rlols5_2000p.flv?wsAuth=e049f6ce59b60a4c5172045f2b649510\u0026token=app-ios-0-288016-e9416291174176ee57f96e95b9a1f8b842315f95c3910b0e\u0026logo=0\u0026expire=0\u0026did=4e0eb51fd02bafb072b9e49300001521\u0026ver=4.600\u0026pt=1\u0026st=0\u0026mix=0
      
//        url = "\(url!)\(live)"
//        let ffoptions :IJKFFOptions = IJKFFOptions.byDefault()
//        ffoptions.setPlayerOptionValue("1", forKey: "videotoolbox")
//        ffoptions.setPlayerOptionValue("29.97", forKey: "r")
//        player = IJKFFMoviePlayerController.init(contentURLString: url, with: ffoptions)
//        player?.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
//        view.addSubview((player?.view)!)
//        player?.view.backgroundColor = UIColor.clear
//        player?.view.frame = CGRect.make(0, 100, KScreenWidth, KScreenWidth/4*3)
//        player?.scalingMode = .aspectFill
//        player?.prepareToPlay()
//        player?.setPauseInBackground(true)
        
        view.addSubview(playContainter)
        playContainter.play_url = url
    }

    private lazy var playContainter :DYPlayerContainter = {
        let frame = CGRect.make(0, 100, KScreenWidth, KScreenWidth/4*3)
        let view = DYPlayerContainter(frame: frame)
        return view
    }()
    deinit {
        playContainter.shutDown()
    }
}

//{
//    "error": 0,
//    "msg": "ok",
//    "data": {
//        "rtmp_cdn": "tct",
//        "cdns": ["ws", "tct", "ws2"],
//        "cdnsWithName": [{
//        "name": "主线路",
//        "cdn": "ws"
//        }, {
//        "name": "备用线路5",
//        "cdn": "tct"
//        }, {
//        "name": "备用线路2",
//        "cdn": "ws2"
//        }],
//        "mixed_url": "",
//        "mixedCDN": "",
//        "streamStatus": 1,
//        "rtmp_url": "http://tc-tct.douyucdn2.cn/dyliveflv1",
//        "rtmp_live": "288016rlols5_2000p.flv?wsAuth=ad2095e2b45b987097baea7b5bc9e216\u0026token=app-ios-0-288016-e9416291174176ee7666d1697b3113a126639d3599ca2ecf\u0026logo=0\u0026expire=0\u0026did=4e0eb51fd02bafb072b9e49300001521\u0026ver=4.600\u0026pt=1\u0026st=0\u0026mix=0",
//        "room_id": 288016,
//        "owner_uid": 19344409,
//        "player_1": "",
//        "clientIP": "111.198.228.87",
//        "rateSwitch": 1,
//        "rateSetting": [{
//        "name": "蓝光10M",
//        "rate": 0,
//        "highBit": 1
//        }, {
//        "name": "蓝光4M",
//        "rate": 4,
//        "highBit": 1
//        }, {
//        "name": "超清",
//        "rate": 3,
//        "highBit": 0
//        }, {
//        "name": "高清",
//        "rate": 2,
//        "highBit": 0
//        }, {
//        "name": "流畅",
//        "rate": 1,
//        "highBit": 0
//        }],
//        "hightBit": 0,
//        "is_pass_player": 0,
//        "eticket": [],
//        "rate": 3,
//        "hls_url": "",
//        "p2p": 1,
//        "streamType": 0
//    }
//}
