//
//  DYPlayerContainter.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/24.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
import IJKMediaFramework
private let KMargin:CGFloat = 10

class LoadingView: UIView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(activityView)
        activityView.snp.makeConstraints { (make) in
            make.centerX.centerY.equalToSuperview().offset(0)
            make.width.height.equalTo(40)
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var activityView :UIActivityIndicatorView = {
        let view = UIActivityIndicatorView.init(activityIndicatorStyle: .whiteLarge)
        return view
    }()
    
    func startLoading(){
        self.isHidden = false
        activityView.startAnimating()
    }
    
    func stopLoading(){
        activityView.stopAnimating()
        self.isHidden = true
    }
}

@objc protocol DYPlayerControlDelegate {
    @objc optional func sliderValueChanged(slider:UISlider)
    @objc optional func sliderTouchDown(slider:UISlider)
    @objc optional func playButton(state:Bool)
}

class DYPlayerControl: UIView {
    
    var current:String?{
        didSet{
            currentTime.text = current
        }
    }
    
    var duration:String?{
        didSet{
            totalTime.text = duration
        }
    }
    
    var delegate:DYPlayerControlDelegate?
    private var playControlHidden:Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func reset() {
        currentTime.text = "00:00"
        totalTime.text = "00:00"
        slider.setValue(0, animated: false)
        playButton.isSelected = false
        playButton.setImage(UIImage(named: "btn_video_pause_white18"), for: .normal)
    }
    
    private func setupUI() {
        addSubview(topView)
        addSubview(middleView)
        addSubview(bottomView)
        
        topView.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(KMargin)
            make.right.equalToSuperview().offset(-KMargin)
            make.height.equalTo(30)
        }
        
        middleView.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(0)
            make.left.right.equalTo(topView)
            make.bottom.equalTo(-35)
        }
        
        bottomView.snp.makeConstraints { (make) in
            make.top.equalTo(middleView.snp.bottom).offset(0)
            make.left.right.equalTo(topView)
            make.bottom.equalToSuperview().offset(0)
        }
        
        // 标题
        topView.addSubview(titleL)
        titleL.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview().offset(0)
        }
        
        // 播放/暂停
        middleView.addSubview(playButton)
        let WH : CGFloat = 40
        playButton.layer.cornerRadius = WH/2
        playButton.layer.masksToBounds = true
        playButton.snp.makeConstraints { (make) in
            make.width.height.equalTo(WH)
            make.centerX.centerY.equalToSuperview().offset(0)
        }
        
        // 播放时间
        bottomView.addSubview(currentTime)
        currentTime.snp.makeConstraints { (make) in
            make.width.equalTo(40)
            make.left.bottom.top.equalToSuperview().offset(0)
        }
        
        // 总时长
        bottomView.addSubview(totalTime)
        totalTime.snp.makeConstraints { (make) in
            make.right.bottom.top.equalToSuperview().offset(0)
            make.width.equalTo(currentTime)
        }
        
        // slider
        bottomView.addSubview(slider)
        slider.snp.makeConstraints { (make) in
            make.left.equalTo(currentTime.snp.right).offset(5)
            make.right.equalTo(totalTime.snp.left).offset(-5)
            make.bottom.top.equalToSuperview().offset(0)
        }
        
        reset()
        
        let tap = UITapGestureRecognizer.init(target: self, action: #selector(playControlTap(_:)))
        self.addGestureRecognizer(tap)
    }
    
    func hidePlayControl(){
        self.perform(#selector(hide), with: nil, afterDelay: 5.0)
    }
    
    @objc private func hide(){
        UIView.animate(withDuration: 0.25) {
            self.topView.alpha = 0.0
            self.middleView.alpha = 0.0
            self.bottomView.alpha = 0.0
        }
        playControlHidden = true
    }
    
    @objc private func show(){
        UIView.animate(withDuration: 0.25) {
            self.topView.alpha = 1.0
            self.middleView.alpha = 1.0
            self.bottomView.alpha = 1.0
        }
        playControlHidden = false
    }
    
    func cancelPerform(){
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(hide), object: nil)
    }
    
    @objc func playControlTap(_ tapGesture:UITapGestureRecognizer){
        cancelPerform()
        if playControlHidden{
            show()
            hidePlayControl()
        }else{
            hide()
        }
    }
    
    private lazy var topView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var middleView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var bottomView:UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.clear
        return view
    }()
    
    private lazy var titleL:UILabel = {
        let view = UILabel()
        view.textColor = UIColor.white
        view.font = UIFont.systemFont(ofSize: 15)
        view.numberOfLines = 1
        return view
    }()
    
    private lazy var playButton:UIButton = {
        let view = UIButton()
        view.backgroundColor = UIColor.colorWithRGB(r: 0, g: 0, b: 0, l: 0.5)
        view.addTarget(self, action: #selector(playButtonClick(_:)), for: .touchUpInside)
        view.setImage(UIImage(named: "btn_video_pause_white18"), for: .normal)
        view.isSelected = false
        return view
    }()
    
    private lazy var currentTime:UILabel = {
        let view = UILabel()
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor.white
//        view.backgroundColor = UIColor.red
        view.sizeToFit()
        return view
    }()
    
    private lazy var totalTime:UILabel = {
        let view = UILabel()
        view.textAlignment = .right
        view.font = UIFont.systemFont(ofSize: 13)
        view.textColor = UIColor.white
//        view.backgroundColor = UIColor.red
        view.sizeToFit()
        return view
    }()
    
    lazy var slider:UISlider = {
        let view = UISlider()
//        view.backgroundColor = UIColor.red
        view.minimumValue = 0.0
        view.maximumValue = 1.0
        let image :UIImage = UIImage.imageWithColor(color: UIColor.white, viewSize: CGSize(width: 15, height: 15))
        view.setThumbImage(image.circleImage(), for: .normal)
        view.minimumTrackTintColor = UIColor.orange
        view.maximumTrackTintColor = UIColor.white
        view.isContinuous = false
        view.addTarget(self, action: #selector(sliderValueChanged(_:)), for: .valueChanged)
        view.addTarget(self, action: #selector(sliderTouchDown(_:)), for: .touchDown)
        return view
    }()
    
    @objc func sliderValueChanged(_ slider:UISlider){
        delegate?.sliderValueChanged?(slider: slider)
         print("sliderValueChanged")
    }
    
    @objc func sliderTouchDown(_ slider:UISlider){
        delegate?.sliderTouchDown?(slider: slider)
        print("sliderTouchDown")
    }
    
    @objc func playButtonClick(_ button:UIButton){
        cancelPerform()
        button.isSelected = !button.isSelected
        if button.isSelected {
            playButton.setImage(UIImage(named: "btn_video_play_white18"), for: .selected)
        }else{
            playButton.setImage(UIImage(named: "btn_video_pause_white18"), for: .normal)
        }
        hidePlayControl()
        delegate?.playButton?(state: button.isSelected)
    }
}

class DYPlayerContainter: UIView , DYPlayerViewDelegate,DYPlayerControlDelegate{
   
    var player :DYPlayerView?
    var playFinish:Bool = false
    var play_url:String?{
        didSet{
            guard let _ = play_url else {return}
            player = DYPlayerView(frame: self.bounds, play_url: play_url!)
            player?.delegate = self
            addSubview(player!)
            addSubview(playControl)
            playControl.frame = self.bounds
            playControl.delegate = self
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.clear
        addSubview(loadingView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var playControl :DYPlayerControl = {
        let view = DYPlayerControl()
        return view
    }()
    
    lazy var loadingView :LoadingView = {
        let view = LoadingView()
        view.startLoading()
        view.backgroundColor = UIColor.colorWithRGB(r: 0, g: 0, b: 0, l: 1.0)
        view.frame = self.bounds
        return view
    }()
}

extension DYPlayerContainter {
    func loadStateDidChange(noti: Notification) {
        let loadState :IJKMPMovieLoadState = player!.player!.loadState

    }
    
    func playFinished(noti: Notification) {
        print("playFinished ====")
        playFinish = true
        cancelRefresh()
    }
    
    func readyToPlay(noti: Notification) {
        print("readyToPlay ==== \(player!.player!.isPreparedToPlay)")
        if player!.player!.isPreparedToPlay{
            playControl.duration = getTime(time: CGFloat(player!.player!.duration))
            player!.play()
            loadingView.stopLoading()
            playControl.hidePlayControl()
            refreshSlider()
        }
    }
    
    func playbackStateDidChange(noti: Notification) {
        print("playbackStateDidChange ==== \(player!.player!.bufferingProgress)")
    }
    
    func shutDown(){
        playControl.reset()
        player?.shutdown()
    }
    
    func prepareToPlay(){
        playControl.reset()
        player?.prepareToPlay()
    }
    
    private func getTime(time:CGFloat) -> String{
        var t = ""
        let time = String(format: "%0.2f", Float(time/60))
        let temp:[String] = time.components(separatedBy: ".")
        if temp.count > 1{
            var minute = temp.first!
            var second = Int(temp.last!)
            if second! >= 60 {second = 59}
            minute = String(format: "%02d", Int(minute)!)
            let sec = String(format: "%02.f", Float(second!))
            t = "\(minute):\(String(sec))"
        }
        return t
    }
}

extension DYPlayerContainter{
    @objc func refreshSlider(){
        var time = player!.player!.currentPlaybackTime
        let min = String(format: "%02d", Int(time/60))
        if CGFloat(time) >= 60 {
            time = 0
        }
        let sec = String(format: "%02d",Int(time))
        playControl.current = "\(min):\(sec)"
        let progress = Float(player!.player!.currentPlaybackTime/player!.player!.duration)
        playControl.slider.setValue(progress, animated: true)
        self.perform(#selector(refreshSlider), with: nil, afterDelay: 1.0)
    }
    
    func cancelRefresh() {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(refreshSlider), object: nil)
    }
    
    func sliderTouchDown(slider: UISlider) {
        playControl.cancelPerform()
    }
    
    func sliderValueChanged(slider: UISlider) {
        let currentTime = TimeInterval(slider.value) * player!.player!.duration
        player!.player!.currentPlaybackTime = currentTime
        loadingView.startLoading()
        playControl.hidePlayControl()
        if playFinish {
            refreshSlider()
        }
        
    }
    
    func playButton(state: Bool) {
        if state { // pause
            player?.pause()
            cancelRefresh()
        }else{ // play
            player?.play()
            refreshSlider()
        }
    }
}
