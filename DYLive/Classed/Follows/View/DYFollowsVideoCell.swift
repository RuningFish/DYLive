//
//  DYFollowsVideoCell.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

class DYFollowsVideoCell: UITableViewCell {

    var videoModel : DYFollowsVideoModel? {
        didSet{
            if let iconURL = URL(string: videoModel?.video_cover ?? "") {
                video_cover.kf.setImage(with: iconURL)
            } else {
                video_cover.image = UIImage(named: "home_column_more")//home_more_btn
            }
            
            if let ownerURL = URL(string: videoModel?.owner_avatar ?? "") {
                owner_avatar.kf.setImage(with: ownerURL)
            } else {
                owner_avatar.image = UIImage(named: "home_column_more")
            }
            
            video_titleL.text = videoModel?.video_title
            if Int(videoModel!.view_num!) > 10000 {
                var count = Double(CGFloat((videoModel?.view_num)!)/1000).rounded()
                count = count/Double(10)
                view_numL.text = "\(count)万次播放"
            }else {
                view_numL.text = "\(Int(videoModel!.view_num!))万次播放"
            }
            let str = " "
            cate2_nameL.text = " * \((videoModel!.cate2_name)!) \(str)"
            nicknameL.text = videoModel!.nickname
            video_str_durationL.text = videoModel!.video_str_duration
        }
    }
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.selectionStyle = .none
        setupUI()
        setLayout()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private lazy var video_cover :UIImageView = {() in
        let view = UIImageView()
        
        return view
    }()
    
    private lazy var owner_avatar :UIImageView = {() in
        let view = UIImageView()
        view.layer.cornerRadius = 25
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var video_titleL :UILabel = {() in
        let view = UILabel()
        view.textColor = UIColor.white
        view.font = UIFont(name: Helvetica_Bold, size: 16)
        view.numberOfLines = 2
        return view
    }()
    
    private lazy var video_str_durationL :UILabel = {() in
        let view = UILabel()
        view.font = UIFont.systemFont(ofSize: 14)
        view.textAlignment = .right
        view.textColor = UIColor.white
        return view
    }()
    
    private lazy var cate2_nameL :UILabel = {() in
        let view = UILabel()
        view.textColor = UIColor.black
        view.font = UIFont(name: PingFangSC_Light, size: 14)
        view.backgroundColor = UIColor.white
        view.layer.cornerRadius = 3
        view.layer.masksToBounds = true
        return view
    }()
    
    private lazy var view_numL :UILabel = {() in
        let view = UILabel()
        view.textColor = UIColor.white
        view.font = UIFont(name: PingFangSC_Light, size: 14)
        return view
    }()
    
    private lazy var nicknameL :UILabel = {() in
        let view = UILabel()
        view.textColor = UIColor.black
        view.font = UIFont(name: PingFangSC_Light, size: 16)
        return view
    }()
}

extension DYFollowsVideoCell{
    func setupUI() {
        contentView.addSubview(video_cover)
        contentView.addSubview(video_titleL)
        contentView.addSubview(view_numL)
        contentView.addSubview(cate2_nameL)
        contentView.addSubview(nicknameL)
        contentView.addSubview(owner_avatar)
        contentView.addSubview(video_str_durationL)
    }
    
    func setLayout() {
        video_cover.snp.makeConstraints { (make) in
            make.left.top.right.equalToSuperview().offset(0)
            make.height.equalTo(KScreenWidth/16*9)
        }
        
        video_titleL.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.top.equalTo(5)
            make.right.equalToSuperview().offset(-10)
            make.height.equalTo(35)
        }
        
        view_numL.snp.makeConstraints { (make) in
            make.left.equalTo(video_titleL.snp.left).offset(0)
            make.top.equalTo(video_titleL.snp.bottom).offset(0)
            make.height.equalTo(20)
        }
        
        cate2_nameL.snp.makeConstraints { (make) in
            make.left.equalTo(view_numL.snp.right).offset(5)
            make.centerY.height.equalTo(view_numL).offset(0)
        }
        
        nicknameL.snp.makeConstraints { (make) in
            make.left.equalTo(video_titleL).offset(0)
            make.top.equalTo(video_cover.snp.bottom).offset(0)
            make.bottom.equalToSuperview().offset(0)
        }
        
        owner_avatar.snp.makeConstraints { (make) in
            make.left.equalTo(video_titleL).offset(0)
            make.bottom.equalTo(video_cover.snp.bottom).offset(10)
            make.width.height.equalTo(50)
        }
        
        video_str_durationL.snp.makeConstraints { (make) in
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalTo(video_cover).offset(-10)
            make.height.equalTo(cate2_nameL)
        }
    }
}
