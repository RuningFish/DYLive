//
//  DYStartLiveViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/10.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import LFLiveKit
class DYStartLiveViewController: UIViewController,LFLiveSessionDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clear
        requestPermissionForVideo()
        requestPermissionForAudio()
        setupUI()
        addConstraint()
    }

    lazy var session: LFLiveSession = {
        let audioConfiguration = LFLiveAudioConfiguration.defaultConfiguration(for: LFLiveAudioQuality.high)
        let videoConfiguration = LFLiveVideoConfiguration.defaultConfiguration(for: LFLiveVideoQuality.low3, outputImageOrientation: .portrait)
        let session = LFLiveSession(audioConfiguration: audioConfiguration, videoConfiguration: videoConfiguration)
        session?.captureDevicePosition = .back
        session?.beautyFace = true
        session?.delegate = self
        session?.preView = self.view
        return session!
    }()

    //MARK: - Event
    func startLive() -> Void {
        let stream = LFLiveStreamInfo()
        stream.url = KStream_url
        session.startLive(stream)
    }

    func stopLive() -> Void {
        session.running = false
        session.stopLive()
    }

    lazy var containerView :UIView = {() in
        let view = UIView()
        return view
    }()
    
    lazy var stateLabel :UILabel = {() in
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        return view
    }()

    lazy var beauty :UIButton = { () in
        let view = UIButton()
        view.setImage(UIImage(named:"camra_beauty"), for:.normal)
        view.setImage(UIImage(named:"camra_beauty_close"), for:.selected)
        view.addTarget(self, action: #selector(didClickBeautyButton(_:)), for: .touchUpInside)
        return view
    }()

    lazy var camera :UIButton = { () in
        let view = UIButton()
        view.setImage(UIImage(named:"camra_preview"), for:.normal)
        view.addTarget(self, action: #selector(didClickCameraButton(_:)), for: .touchUpInside)
        return view
    }()

    lazy var close :UIButton = { () in
        let view = UIButton()
        view.setImage(UIImage(named:"close_preview"), for:.normal)
        view.addTarget(self, action: #selector(didClickCloseButton(_:)), for: .touchUpInside)
        return view
    }()
    
    deinit {
        print("-----------deinit ")
        stopLive()
    }
}


extension DYStartLiveViewController{

    func requestPermissionForVideo(){
        let status :AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .video)
        switch status {
        case .denied,.restricted:
             print("--------")
        case .authorized:
            DispatchQueue.main.async {
                self.session.running = true
                self.startLive()
            }
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .video, completionHandler: { (result) in
                if result{
                    DispatchQueue.main.async {
                        self.session.running = true
                        self.startLive()
                    }
                }
            })
        }
    }

    func requestPermissionForAudio(){
       let status :AVAuthorizationStatus = AVCaptureDevice.authorizationStatus(for: .audio)
        switch status {
        case .denied,.restricted:
            print("麦克风没有访问权限--------")
        case .authorized:
            print("麦克风有访问权限--------")
        case .notDetermined:
            AVCaptureDevice.requestAccess(for: .audio, completionHandler: { (result) in

            })
        }
    }

    func setupUI(){
        view.addSubview(containerView)
        containerView.addSubview(stateLabel)
        containerView.addSubview(beauty)
        containerView.addSubview(camera)
        containerView.addSubview(close)

//        stateLabel.backgroundColor = UIColor.random_color()
//        beauty.backgroundColor = UIColor.random_color()
//        camera.backgroundColor = UIColor.random_color()
    }

    func addConstraint() {
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(30)
            make.right.equalToSuperview().offset(-30)
            make.top.equalToSuperview().offset(100)
            make.height.equalTo(50)
        }
        
        stateLabel.snp.makeConstraints { (make) in
            make.left.equalTo(0)
//            make.top.equalTo(0)
            make.centerY.equalTo(0)
            make.width.equalTo(60)
        }

        beauty.snp.makeConstraints { (make) in
            make.left.equalTo(stateLabel.snp.right).offset(20)
            make.centerY.equalTo(0)
            make.width.height.equalTo(25)
        }

        camera.snp.makeConstraints { (make) in
            make.left.equalTo(beauty.snp.right).offset(20)
            make.centerY.equalTo(0)
            make.width.height.equalTo(beauty)
        }
        
        close.snp.makeConstraints { (make) in
            make.right.equalTo(0)
            make.centerY.equalTo(0)
            make.width.height.equalTo(camera)
        }
    }

        // 美颜
        @objc func didClickBeautyButton(_ button: UIButton) -> Void {
            session.beautyFace = !session.beautyFace;
            beauty.isSelected = !session.beautyFace
        }

        // 摄像头
        @objc func didClickCameraButton(_ button: UIButton) -> Void {
            let devicePositon = session.captureDevicePosition;
            session.captureDevicePosition = (devicePositon == .back) ? .front : .back;
        }

        // 关闭
        @objc func didClickCloseButton(_ button: UIButton) -> Void  {
            self.stopLive()
            self.navigationController?.popViewController(animated: true)
            self.dismiss(animated: false, completion: nil)
        }

}

extension DYStartLiveViewController{
    func liveSession(_ session: LFLiveSession?, liveStateDidChange state: LFLiveState) {
        print("liveSession liveStateDidChange\(state)")
        switch state {
        case .ready:
            stateLabel.text = "准备"
        case .pending:
            stateLabel.text = "连接中"
        case .start:
            stateLabel.text = "已连接"
        case .stop:
            stateLabel.text = "已断开"
        case .error:
            stateLabel.text = "连接出错"
        case .refresh:
            stateLabel.text = "正在刷新"
        }
    }

    func liveSession(_ session: LFLiveSession?, debugInfo: LFLiveDebug?) {
        print("liveSession debugInfo\(debugInfo)")
    }

    func liveSession(_ session: LFLiveSession?, errorCode: LFLiveSocketErrorCode) {
        print("liveSession errorCode\(errorCode)")
    }
}


