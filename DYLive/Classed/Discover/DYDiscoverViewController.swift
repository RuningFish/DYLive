//
//  DiscoverViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import IJKMediaFramework
class DYDiscoverViewController: DYBaseViewController {
    
    private var player :IJKMediaPlayback?
    var url:String?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addSubview(playButton)
        playButton.snp.makeConstraints { (make) in
            make.width.equalTo(80)
            make.height.equalTo(25)
            make.centerX.equalToSuperview().offset(0)
            make.centerY.equalToSuperview().offset(50)
        }
    }
    
    
    private lazy var playButton :UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("播放", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.tag = 100
        view.backgroundColor = UIColor.red
        view.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        return view
    }()
    
    private lazy var pauseButton :UIButton = {
        let view = UIButton.init(type: .custom)
        view.setTitle("暂停", for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        view.tag = 200
        view.backgroundColor = UIColor.red
        view.addTarget(self, action: #selector(buttonClick(_:)), for: .touchUpInside)
        return view
    }()
    
    @objc func buttonClick(_ button:UIButton){
        url = "http://7xlv47.com1.z0.glb.clouddn.com/xxx004.m3u8"
        playVideoWithURL(url: url!)
    }
    
    private func playVideoWithURL(url :String?) {
        guard let _ = url else{return}
        player?.shutdown()
        player = IJKAVMoviePlayerController.init(contentURLString: url)
        player?.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        view.addSubview((player?.view)!)
        player?.view.backgroundColor = UIColor.green
        player?.view.frame = CGRect.make(0, 100, KScreenWidth, KScreenWidth/16*9)
        player?.scalingMode = .aspectFill
        player?.prepareToPlay()
        player?.shouldAutoplay = true
    }
}
