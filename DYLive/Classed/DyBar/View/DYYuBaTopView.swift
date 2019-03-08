//
//  DYYuBaTopView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/5.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
private let margin :CGFloat = 5
class DYYuBaTopView: UIView {

    var model : DYYuBaModel? {
        didSet{
            if let iconURL = URL(string: model?.avatar ?? "") {
                userIcon.kf.setImage(with: iconURL)
            } else {
                userIcon.image = UIImage(named: "home_column_more")
            }
            userName.text = model?.nick_name
            // sex
            sex.snp.removeConstraints()
            level.snp.removeConstraints()
            if model?.sex == 0{
                sex.isHidden = true
//                sex.snp.removeConstraints()
                level.snp.makeConstraints { (make) in
                    make.left.equalTo(userName.snp.right).offset(margin)
                    make.top.equalTo(userIcon.snp.top).offset(0)
                    make.height.equalTo(15)
                    make.width.equalTo(50)
                }
                
            }else{
                if model?.sex == 2 {
                    sex.image = UIImage(named:"image_fillInfoAlert_female_unselected")
                    sex.backgroundColor = UIColor.colorWithRGB(r: 255, g: 85, b: 98)
                }else if model?.sex == 1{
                    sex.image = UIImage(named:"image_fillInfoAlert_male_unselected")
                    sex.backgroundColor = UIColor.colorWithRGB(r: 116, g: 133, b: 254)
                }
                
                sex.isHidden = false
                sex.snp.makeConstraints { (make) in
                    make.left.equalTo(userName.snp.right).offset(margin)
                    make.top.equalTo(userIcon.snp.top).offset(0)
                    make.width.height.equalTo(15)
                }
                
                level.snp.makeConstraints { (make) in
                    make.left.equalTo(sex.snp.right).offset(margin)
                    make.top.equalTo(userIcon.snp.top).offset(0)
                    make.height.equalTo(sex.snp.height)
                    make.width.equalTo(50)
                }
            }
            // level
            
            time.text = model?.created_at
            if Int(model!.views!) > 10000 {
                var count = Double(CGFloat((model?.views)!)/1000).rounded()
                count = count/Double(10)
                readCount.text = "\(count)万阅读"
            }else{
                readCount.text = "\(model!.views!)阅读"
            }
            
//            location.text = beauty?.anchor_city
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupUI()
        setConstraint()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // lazy
    lazy var userIcon :UIImageView = { () in
       let imageView = UIImageView()
       return imageView
    }()
    
    lazy var sex :UIImageView = { () in
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
    lazy var arrow :UIImageView = { () in
        let imageView = UIImageView()
        imageView.image = UIImage(named:"groupDetail_arrow_icon")
        imageView.contentMode = .center
        return imageView
    }()
    
    lazy var level :UIImageView = { () in
        let imageView = UIImageView()
        return imageView
    }()
    

    lazy var userName :UILabel = { () in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 14)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 0
        return label
    }()
    
    lazy var time :UILabel = { () in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var readCount :UILabel = { () in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
}

extension DYYuBaTopView {
    func setupUI(){
        addSubview(userIcon)
        addSubview(userName)
        addSubview(sex)
        addSubview(level)
        addSubview(time)
        addSubview(readCount)
        addSubview(arrow)
        
        userName.sizeToFit()
        time.sizeToFit()
        readCount.sizeToFit()
        
        userIcon.backgroundColor = UIColor.random_color()
//        userName.backgroundColor = UIColor.random_color()
        sex.backgroundColor = UIColor.random_color()
        level.backgroundColor = UIColor.random_color()
//        time.backgroundColor = UIColor.random_color()
//        readCount.backgroundColor = UIColor.random_color()
//        arrow.backgroundColor = UIColor.random_color()
        
        userName.text = "旭旭姥姥6868"
        time.text = "8分钟前"
        readCount.text = "1.3万阅读"
        userIcon.layer.cornerRadius = 18
        userIcon.layer.masksToBounds = true
    }
    
    func setConstraint() {
        userIcon.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(20)
            make.top.equalToSuperview().offset(15)
            make.width.height.equalTo(36)
        }
        
        userName.snp.makeConstraints { (make) in
            make.left.equalTo(userIcon.snp.right).offset(margin*2)
            make.top.equalTo(userIcon.snp.top).offset(-3)
            make.height.equalTo(20)
        }
        
        time.snp.makeConstraints { (make) in
            make.left.equalTo(userName.snp.left).offset(0)
            make.top.equalTo(userName.snp.bottom).offset(margin)
            make.bottom.equalTo(userIcon.snp.bottom).offset(0)
        }
        
        readCount.snp.makeConstraints { (make) in
            make.left.equalTo(time.snp.right).offset(margin*2)
            make.top.equalTo(time.snp.top).offset(0)
            make.height.equalTo(time.snp.height)
            make.bottom.equalTo(-10)
        }
        
        arrow.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-20)
            make.centerY.equalToSuperview().offset(0)
            make.width.height.equalTo(15)
        }
    }
}
