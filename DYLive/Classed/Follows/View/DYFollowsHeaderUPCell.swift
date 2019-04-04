//
//  DYFollowsHeaderUPCell.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
private let KIconH :CGFloat = 60
class DYFollowsHeaderUPCell: UICollectionViewCell {
    var upModel : DYFollowsVideoHeaderModel?{
        didSet{
            if upModel == nil {return}
            if let iconURL = URL(string: upModel?.icon ?? "") {
                icon.kf.setImage(with: iconURL)
            } else {
                icon.image = UIImage(named: "home_column_more")
            }
            
            nickNameL.text = upModel!.nickName
            contentsL.text = upModel!.contents
        }
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    private lazy var icon : UIImageView = { () in
        let view = UIImageView()
        view.layer.cornerRadius = KIconH/2
        view.layer.masksToBounds = true
        view.backgroundColor = UIColor.random_color()
        return view
    }()
    
    private lazy var nickNameL : UILabel = { () in
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont(name: Helvetica_Bold, size: 15)
        return view
    }()
    
    private lazy var contentsL : UILabel = { () in
        let view = UILabel()
        view.textAlignment = .center
        view.font = UIFont(name: PingFangSC_Light, size: 12)
        view.textColor = UIColor.lightGray
        return view
    }()
    
    private lazy var bottomView : UIView = { () in
        let view = UIView()
        view.backgroundColor = UIColor.colorWithRGB(r: 246, g: 247, b: 248)
        return view
    }()
}

extension DYFollowsHeaderUPCell{
    func setupUI() {
        addSubview(bottomView)
        addSubview(icon)
        bottomView.addSubview(nickNameL)
        bottomView.addSubview(contentsL)
        
        
        bottomView.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(30)
            make.bottom.equalTo(-10)
        }
        
        icon.snp.makeConstraints { (make) in
            make.centerX.equalTo(bottomView.snp.centerX).offset(0)
            make.top.equalTo(bottomView.snp.top).offset(-20)
            make.width.height.equalTo(KIconH)
        }
        
        nickNameL.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(icon.snp.bottom).offset(10)
            make.height.equalTo(20)
        }
        
        contentsL.snp.makeConstraints { (make) in
            make.left.right.equalTo(0)
            make.top.equalTo(nickNameL.snp.bottom).offset(10)
            make.height.equalTo(nickNameL)
        }
    }
}
