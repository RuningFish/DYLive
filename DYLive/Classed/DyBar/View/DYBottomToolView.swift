//
//  DYBottomToolView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/7.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYBottomToolView: UIView {

    var model : DYYuBaModel? {
        didSet{
            guard let mod = model else {return}
            let width = (mod.group_name?.xsy_widthForComment(fontSize: 12, height: 20))! + 15
            group_name.snp.removeConstraints()
            group_name.snp.makeConstraints { (make) in
                make.left.equalToSuperview().offset(KContentLeftMargin)
                make.width.equalTo(width)
                make.centerY.equalToSuperview().offset(0)
                make.height.equalTo(20)
            }
            
            group_name.text = mod.group_name
            if mod.reposts > 0 {
                transmit.setTitle("\(mod.reposts)", for: .normal)
            }
            if mod.total_comments > 0{
                total_comments.setTitle("\(mod.total_comments)", for: .normal)
            }
            if mod.likes > 0{
                likes.setTitle("\(mod.likes)", for: .normal)
            }
            
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // lazy
    
    // group_name
    lazy var group_name :UILabel = { () in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        label.textAlignment = .center
        return label
    }()
    
    lazy var transmit : UIButton = { () in
        let view = UIButton()
        view.setTitle("转发", for: .normal)
        view.setTitleColor(UIColor.lightGray, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        view.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        view.titleLabel?.textAlignment = .right
        return view
    }()
    
    lazy var total_comments : UIButton = { () in
        let view = UIButton()
        view.setTitle("评论", for: .normal)
        view.setTitleColor(UIColor.lightGray, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 13)
        view.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        view.titleLabel?.textAlignment = .right
        return view
    }()
    
    lazy var likes : UIButton = { () in
        let view = UIButton()
        view.setTitle("点赞", for: .normal)
        view.setTitleColor(UIColor.lightGray, for: .normal)
        view.titleLabel?.font = UIFont.systemFont(ofSize: 12)
        view.titleEdgeInsets = UIEdgeInsets.init(top: 0, left: 10, bottom: 0, right: 0)
        view.titleLabel?.textAlignment = .right
        return view
    }()
    
    lazy var bottomLine : UIView = { () in
        let view = UIView()
        view.backgroundColor = UIColor.colorWithRGB(r: 247, g: 247, b: 247)
        return view
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        group_name.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(KContentLeftMargin)
            make.centerY.equalToSuperview().offset(0)
            make.height.equalTo(20)
        }
        
        likes.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-KContentLeftMargin)
            make.centerY.equalToSuperview().offset(0)
            make.width.equalTo(60)
            make.height.equalTo(20)
        }
        
        total_comments.snp.makeConstraints { (make) in
            make.right.equalTo(likes.snp.left).offset(-10)
            make.width.height.centerY.equalTo(likes)
        }
        
        transmit.snp.makeConstraints { (make) in
            make.right.equalTo(total_comments.snp.left).offset(-10)
            make.width.height.centerY.equalTo(likes)
        }
        
        bottomLine.snp.makeConstraints { (make) in
            make.left.bottom.right.equalToSuperview().offset(0)
            make.height.equalTo(5)
        }
    }
    
}

extension DYBottomToolView {
    func setupUI(){
        addSubview(group_name)
        addSubview(transmit)
        addSubview(total_comments)
        addSubview(likes)
        addSubview(bottomLine)
        
        group_name.sizeToFit()
        group_name.layer.cornerRadius = 10
        group_name.layer.masksToBounds = true
        group_name.backgroundColor = UIColor.colorWithRGB(r: 247, g: 247, b: 247)
        group_name.text = "斗鱼直播"
        transmit.setImage(UIImage(named:"yb_post_share_icon"), for: .normal)
        total_comments.setImage(UIImage(named:"siteMessageUser"), for: .normal)
        likes.setImage(UIImage(named:"image_my_focus"), for: .normal)
//        transmit.backgroundColor = UIColor.random_color()
//        total_comments.backgroundColor = UIColor.random_color()
//        likes.backgroundColor = UIColor.random_color()
    }
}
