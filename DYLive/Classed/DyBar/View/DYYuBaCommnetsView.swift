//
//  DYYuBaCommnetsView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/6.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYYuBaCommnetsView: UIView {

    var model : DYYuBaModel? {
        didSet{
            if model?.sub_comments?.count == 0 {
                return
            }
            guard let mod = model?.sub_comments![0] as? DYYuBaSubcomments else{return}
            like.text = "\(mod.likes)赞"
            let name = "\(mod.nick_name!):"
            let text = mod.content
            let textCount = text?.characters.count ?? 0
            if name.characters.count + textCount > 24 {
                let prefix = 25 - name.characters.count
                if prefix >= 0{
                    hotComment.text = "\(name)\(text?.prefix(prefix) ?? "")\("...")"
                }else{
                    hotComment.text = name
                }
            }else{
                hotComment.text = "\(name)\(mod.content ?? "")"
            }
//            hotComment.text = "\(name)\(mod.content ?? "")"
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = UIColor.colorWithRGB(r: 247, g: 247, b: 247)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        fatalError("init(coder:) has not been implemented")
    }
    
    // lazy
    lazy var hot : UIButton = { () in
        let view = UIButton()
        view.titleLabel?.font = UIFont.systemFont(ofSize: 9)
        view.setTitleColor(UIColor.black, for: .normal)
        view.setImage(UIImage(named:"YBHP_HP_hot_icon"), for: .normal)
        view.setTitle("热评", for: .normal)
        view.sizeToFit()
        return view
    }()
    
    lazy var like :UILabel = { () in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = UIColor.lightGray
        return label
    }()
    
    lazy var hotComment :UILabel = { () in
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 12)
        label.lineBreakMode = .byWordWrapping
        label.numberOfLines = 1
        return label
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        hot.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.equalToSuperview().offset(5)
            make.height.equalTo(15)
        }

        like.snp.makeConstraints { (make) in
            make.top.equalTo(hot.snp.top).offset(0)
            make.right.equalToSuperview().offset(-10)
        }

        hotComment.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.top.equalTo(hot.snp.bottom).offset(0)
            make.bottom.equalToSuperview().offset(0)
//            make.height.equalTo(20)
        }
    }
    
}

extension DYYuBaCommnetsView {
    func setupUI(){
        addSubview(hot)
        addSubview(like)
        addSubview(hotComment)
    
        hotComment.sizeToFit()
        like.sizeToFit()
        
//        like.backgroundColor = UIColor.random_color()
//        hotComment.backgroundColor = UIColor.random_color()
    }
}

