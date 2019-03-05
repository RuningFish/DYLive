//
//  DYNavigationBar.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import SnapKit

enum  DYNavigationBarItemType: Int{
    case login = 0
    case history = 1
}
protocol DYNavigationBarDelegate {
    func navigationBarItemDidSelect(bar:DYNavigationBar,item:UIImageView,type:DYNavigationBarItemType)
}

class DYNavigationBar: UIView {
    
    // 是否登陆
    var isLogin :Bool = false
    var delegate:DYNavigationBarDelegate?
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
            make.width.height.equalTo(26)
            make.centerY.equalToSuperview().offset(0)
        }
        
        
        if isLogin {
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
        contentView.backgroundColor = UIColor.clear
        self.addSubview(contentView)
        contentView.addSubview(loginImageView)
        contentView.addSubview(searchView)
        contentView.addSubview(historyView)
        contentView.addSubview(messageView)
        
        loginImageView.backgroundColor = UIColor.colorWithRGB(r: 255,g: 141,b: 57)
        searchView.backgroundColor = UIColor.colorWithRGB(r: 255,g: 141,b: 57)
//        historyView.backgroundColor = UIColor.random_color()
        messageView.backgroundColor = UIColor.blue
    }
    
    @objc func imageViewClick(tap:UITapGestureRecognizer){
//        isLogin = !isLogin
//        messageView.isHidden = !isLogin
//        print("\(imageViewClick) +\(isLogin)")
//        layoutSubviews()
        
        guard let login = tap.view as? UIImageView else {return}
        delegate?.navigationBarItemDidSelect(bar: self, item: login, type: .login)
    }
    
    @objc func historyViewClick(tap:UITapGestureRecognizer){
        guard let history = tap.view as? UIImageView else {return}
        delegate?.navigationBarItemDidSelect(bar: self, item: history, type: .history)
    }
    
    // lazy:懒加载
    lazy var contentView = { () -> UIView in
        var contentView = UIView()
        return contentView
        
    }()
    
    // login - icon
    lazy var loginImageView = { () -> UIImageView in
        var imageView = UIImageView()
        imageView.image = UIImage(named:"tf_login_username")
        imageView.contentMode = .center
        imageView.layer.cornerRadius = 13
        imageView.layer.masksToBounds = true
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
        historyView.image = UIImage(named:"image_my_history")
        historyView.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target:self, action:#selector(historyViewClick))
        historyView.addGestureRecognizer(tap)
        return historyView
        
    }()
    
    // message
    lazy var messageView = { () -> UIImageView in
        var messageView = UIImageView()
        messageView.isHidden = true
        return messageView
        
    }()
}
