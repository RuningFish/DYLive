//
//  DYShowLiveController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/11.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

private let KColumn :CGFloat = 4
private let KMargin :CGFloat = 20
private let KWidth  :CGFloat = (KScreenWidth - KMargin*(KColumn+1.0))/KColumn
private let KContainerHeight = (KWidth + KMargin)*2.0
class DYShowLiveController: UIViewController,DYImageTitleViewDelegate {

    private let icons = ["btn_live_home","btn_gamelive_home","btn_audio_live_home","btn_video_home","btn_note_home",]
    private let titles     = ["我要开播","手游直播","语音直播","拍个视频","发布动态",]
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.colorWithRGB(r: 249, g: 249, b: 249, l: 0.8)
        
        view.backgroundColor = UIColor.white
        setupUI()
        addConstraints()
    }

    lazy var close_btn :UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named:"yb_postMenu_close"), for: .normal)
        view.addTarget(self, action: #selector(didClickCloseBtn(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var containerView :UIView = {
        let view = UIView()
        return view
    }()
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
//        UIView.animate(withDuration: 5.0, delay: 5.0 , usingSpringWithDamping: 0.3 , initialSpringVelocity: 8 , options: [] , animations: {
//            print("--------2")
//        }, completion: { (result) in
//            print("--------3 \(result)")
//        })
        
       
    }
}

extension DYShowLiveController{
    func setupUI() {
        view.addSubview(close_btn)
        view.addSubview(containerView)
        
//        close_btn.backgroundColor = UIColor.random_color()
//        containerView.backgroundColor = UIColor.random_color()
        
        let col = Int(KColumn)
        for (index,value) in titles.enumerated(){
            let x = KMargin + (KWidth + KMargin)*CGFloat(index%col)
            let y = KMargin + (KWidth + KMargin)*CGFloat(index/col)
            let frame = CGRect.make(x, y, KWidth, KWidth)
            let view = DYImageTitleView.init(frame: frame, type: .bottom, space: 5)
            view.delegate = self
            view.tag = index
            view.imageView?.image = UIImage(named:icons[index])
            view.titleLabel?.text = value
            view.titleLabel?.textAlignment = .center
            view.titleLabel?.font = UIFont(name:PingFangSC_Light,size:12)
            view.titleLabel?.textColor = UIColor.gray
            containerView.addSubview(view)
        }
        
        return
    }
    
    func addConstraints() {
        close_btn.snp.makeConstraints { (make) in
            make.centerX.equalToSuperview().offset(0)
            make.bottom.equalTo(-KBottomSafeAreaHeight - 15)
            make.width.height.equalTo(30)
        }
        
        containerView.snp.makeConstraints { (make) in
            make.left.equalTo(0)
            make.right.equalTo(0)
            make.bottom.equalTo(close_btn.snp.top).offset(-10)
            make.height.equalTo(KContainerHeight)
//            make.top.equalToSuperview().offset(KScreenHeight)
        }
    }
    
    @objc func didClickCloseBtn(_ button:UIButton){
        self.dismiss(animated: false, completion: nil)
    }
    
    func didClickItem(_ button:UIButton){
        self.present(DYStartLiveViewController(), animated: false) {
//            self.dismiss(animated: false, completion: nil)
        }
    }
    
}

extension DYShowLiveController{
    func didClick(view: DYImageTitleView) {
        if view.tag == 0{
            didClickItem(UIButton())
        }
    }
}
