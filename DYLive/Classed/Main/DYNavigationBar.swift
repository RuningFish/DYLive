//
//  DYNavigationBar.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import SnapKit
class DYNavigationBar: UIView {
    
    // 是否登陆
    var isLogin :Bool = false
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        contentView.snp.makeConstraints { (make) -> () in
            make.left.equalToSuperview().offset(10)
            make.right.equalToSuperview().offset(-10)
            make.bottom.equalToSuperview().offset(0)
            make.height.equalTo(44)
        }
        
        loginImageView.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(0)
            make.width.height.equalTo(35)
            make.centerY.equalToSuperview().offset(0)
        }
        
        
        if isLogin {
            print("xxxxxx")
            searchView.snp.makeConstraints({ (make) in
                make.left.equalTo(loginImageView.snp.right).offset(10)
                make.width.equalTo(100)
                make.centerY.equalToSuperview().offset(0)
                make.height.equalTo(loginImageView)
            })
            
            historyView.snp.makeConstraints({ (make) in
                make.left.equalTo(searchView.snp.right).offset(10)
                make.width.height.equalTo(20)
                make.centerY.equalToSuperview().offset(0)
            })
            
            messageView.snp.makeConstraints({ (make) in
                make.left.equalTo(historyView.snp.right).offset(10)
                make.width.height.equalTo(20)
                make.centerY.equalToSuperview().offset(0)
            })
            
        }else{
            print("sssss")
            historyView.snp.makeConstraints({ (make) in
                make.right.equalToSuperview().offset(-5)
                make.width.height.equalTo(20)
                make.centerY.equalToSuperview().offset(0)
            })

            searchView.snp.makeConstraints({ (make) in
                make.left.equalTo(loginImageView.snp.right).offset(10)
                make.right.equalTo(historyView.snp.left).offset(-15)
                make.centerY.equalToSuperview().offset(0)
                make.height.equalTo(loginImageView)
            })
        }
    }
    
    func setSubviews(){
        print("DYNavigationBar")
        contentView.backgroundColor = UIColor.white
        self.addSubview(contentView)
        contentView.addSubview(loginImageView)
        contentView.addSubview(searchView)
        contentView.addSubview(historyView)
        contentView.addSubview(messageView)
        
        loginImageView.backgroundColor = UIColor.random_color()
        searchView.backgroundColor = UIColor.random_color()
        historyView.backgroundColor = UIColor.random_color()
        messageView.backgroundColor = UIColor.blue
    }
    
    @objc func imageViewClick(){
//        print("imageViewClick")
        isLogin = !isLogin
        messageView.isHidden = !isLogin//contentView.addSubview(messageView):messageView.removeFromSuperview()
        print("\(imageViewClick) +\(isLogin)")
        layoutSubviews()
//        self.layoutIfNeeded()
    }
    // lazy:懒加载
    lazy var contentView = { () -> UIView in
        var contentView = UIView()
        return contentView
        
    }()
    
    // login - icon
    lazy var loginImageView = { () -> UIImageView in
        var imageView = UIImageView()
        imageView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target:self, action:#selector(imageViewClick))
        imageView.addGestureRecognizer(tap)
        return imageView
        
    }()
    
    // search
    lazy var searchView = { () -> UITextField in
        var serchView = UITextField()
        return serchView
        
    }()
    
    // history
    lazy var historyView = { () -> UIImageView in
        var historyView = UIImageView()
        return historyView
        
    }()
    
    // message
    lazy var messageView = { () -> UIImageView in
        var messageView = UIImageView()
        messageView.isHidden = true
        return messageView
        
    }()
}
