//
//  DYTabBarItem.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/3.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYTabBarItem: UIView {

    // 停止标记
    var stop :Bool = false
    var selected:Bool?{
        didSet{
            tabBarIconHigh.isHidden = !selected!
            tabBarIcon.isHidden = selected!
            
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        self.selected = false
        super.init(coder: aDecoder)
    }
    
    // lazy
    lazy var tabBarIcon : UIImageView = { () in
        let imageView = UIImageView()
//        imageView.contentMode = .center
        return imageView
    }()
    
    // lazy
    lazy var tabBarIconHigh : UIImageView = { () in
        let imageView = UIImageView()
//        imageView.contentMode = .center
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var tabBarAnimating : UIImageView = { () in
        let imageView = UIImageView()
        imageView.isHidden = true
        return imageView
    }()
    
    lazy var tabBarTitle : UILabel = { () in
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = UIColor.lightGray
        return label
    }()
}

extension DYTabBarItem{
   private func setupUI(){
        self.addSubview(tabBarIcon)
        self.addSubview(tabBarIconHigh)
        self.addSubview(tabBarTitle)
        self.addSubview(tabBarAnimating)
        
        tabBarTitle.snp.makeConstraints { (make) in
            make.left.right.bottom.equalToSuperview().offset(0)
            make.height.equalTo(15)
        }
        
        tabBarIcon.snp.makeConstraints { (make) in
            make.bottom.equalTo(tabBarTitle.snp.top).offset(0)
            make.centerX.equalToSuperview()
            make.width.height.equalTo(30)
        }
        
        tabBarIconHigh.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(tabBarIcon)
        }
    
        tabBarAnimating.snp.makeConstraints { (make) in
            make.left.right.bottom.top.equalTo(tabBarIcon)
        }
        
        tabBarIconHigh.backgroundColor = UIColor.white
    }
}

extension DYTabBarItem{
    
    func startAnimating(path:String){
        tabBarIconHigh.isHidden = true
        tabBarAnimating.isHidden = false
        guard let data = NSData(contentsOfFile: path),
             let imageSource = CGImageSourceCreateWithData(data, nil) else { return }
    
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0.5
        for i in 0..<CGImageSourceGetCount(imageSource) {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            i == 0 ? tabBarAnimating.image = image : ()
            images.append(image)
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary,
                let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary,
                let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        
        tabBarAnimating.animationImages = images
        tabBarAnimating.animationDuration = totalDuration
        tabBarAnimating.animationRepeatCount = 1
        tabBarAnimating.startAnimating()
    }
    
    func stopAnimating(){
        if stop {
            tabBarAnimating.isHidden = true
            tabBarIcon.isHidden = false
            tabBarIconHigh.isHidden = true
        }else{
            tabBarAnimating.isHidden = true
            selected = true
        }
    }
    
    func stopAtOnce(){
        tabBarAnimating.isHidden = true
        selected = false
        stop = true
    }
}
