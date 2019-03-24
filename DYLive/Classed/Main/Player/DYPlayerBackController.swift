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
        url = "https://v.douyu.com/show/LDBbMAxB0Jn7yJRP"
        player = IJKAVMoviePlayerController.init(contentURLString: url)
        player?.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview((player?.view)!)
        
        player?.view.snp.makeConstraints({ (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(200)
        })
        
        player?.prepareToPlay()
    }

}
