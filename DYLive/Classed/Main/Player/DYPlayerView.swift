//
//  DYPlayerView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/24.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
import IJKMediaFramework

@objc protocol DYPlayerViewDelegate {
    // readyToPlay
   @objc optional func readyToPlay(noti:Notification)
    // PlayFinished
   @objc optional func playFinished(noti:Notification)
    // loadStateChange
   @objc optional func loadStateDidChange(noti:Notification)
    //
   @objc optional func playbackStateDidChange(noti:Notification)
}

class DYPlayerView: UIView {
    let play_url:String?
    var delegate:DYPlayerViewDelegate?
    var player :IJKMediaPlayback?
    init(frame: CGRect,play_url:String) {
        self.play_url = play_url
        super.init(frame: frame)
        
        player?.shutdown()
        player = IJKAVMoviePlayerController.init(contentURLString: play_url)
        player?.view.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        self.addSubview((player?.view)!)
        player?.view.backgroundColor = UIColor.clear
        player?.view.frame = self.bounds
        player?.scalingMode = .aspectFill
        player?.prepareToPlay()
//        player?.shouldAutoplay = true
        player?.setPauseInBackground(true)
        addNotifications()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
// MARK: 方法
extension DYPlayerView{
    func prepareToPlay(){
        player?.prepareToPlay()
    }
    func play(){
        player?.play()
    }
    func pause(){
        player?.pause()
    }
    func shutdown(){
        player?.view.removeFromSuperview()
        player?.shutdown()
        removeNotifications()
    }
    func isPlaying() -> Bool{
        return (player?.isPlaying())!
    }
    
    @objc func loadStateDidChange(_ noti:Notification){
        delegate?.loadStateDidChange!(noti: noti)
    }
    
    // 状态改变
    @objc func playbackStateDidChange(_ noti:Notification){
        delegate?.playbackStateDidChange!(noti: noti)
    }
    
    // 可以播放
    @objc func preparedToPlayDidChange(_ noti:Notification){
        delegate?.readyToPlay!(noti: noti)
    }
    
    // 播放完成
    @objc func playbackDidFinish(_ noti:Notification){
        delegate?.playFinished!(noti: noti)
    }
    
}

// MARK: 通知
extension DYPlayerView{
    private func addNotifications(){
        NotificationCenter.xsyAddobserver(self, selector: #selector(loadStateDidChange(_:)), postName: NSNotification.Name.IJKMPMoviePlayerLoadStateDidChange.rawValue, object: player)
        NotificationCenter.xsyAddobserver(self, selector: #selector(playbackDidFinish(_:)), postName: NSNotification.Name.IJKMPMoviePlayerPlaybackDidFinish.rawValue, object: player)
        NotificationCenter.xsyAddobserver(self, selector: #selector(preparedToPlayDidChange(_:)), postName: NSNotification.Name.IJKMPMediaPlaybackIsPreparedToPlayDidChange.rawValue, object: player)
        NotificationCenter.xsyAddobserver(self, selector: #selector(playbackStateDidChange(_:)), postName: NSNotification.Name.IJKMPMoviePlayerPlaybackStateDidChange.rawValue, object: player)
    }
    
    private func removeNotifications() {
        NotificationCenter.xsyRemoveObserver(self)
    }
}
