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
    private lazy var hot :[String] = [String]()
    private lazy var loadHot = false
    private lazy var afterDelay:TimeInterval = 4.0
    private lazy var hotIndex:NSInteger = 0
    override init(frame: CGRect) {
        super.init(frame: frame)
        setSubviews()
        print("DYNavigationBar ========")
        if loadHot == false {
            getTodayHot {
                self.loadHot = true
//                print("hot \(self.hot)")
                DispatchQueue.main.async { [unowned self] in
                    self.searchLabel.text = self.hot[self.hotIndex]
                    self.perform(#selector(self.changeHotText), with: nil, afterDelay: self.afterDelay)
                }
            }
        }
    }
    
    @objc func changeHotText() {
        hotIndex += 1
        if hotIndex == hot.count{
            hotIndex = 0
        }
        self.searchLabel.text = hot[hotIndex]
        self.perform(#selector(self.changeHotText), with: nil, afterDelay: self.afterDelay)
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
        
        searchImageView.snp.makeConstraints { (make) in
            make.left.equalTo(10)
            make.centerY.equalToSuperview().offset(0)
            make.width.height.equalTo(14)
        }
        
        // searchLabel
        searchLabel.snp.makeConstraints { (make) in
            make.left.equalTo(searchImageView.snp.right).offset(10)
            make.centerY.equalTo(searchImageView)
            make.right.equalToSuperview().offset(-30)
            
        }
    }
    
    func setSubviews(){
        print("DYNavigationBar")
        contentView.backgroundColor = UIColor.clear
        self.addSubview(contentView)
        contentView.addSubview(loginImageView)
        contentView.addSubview(searchView)
        searchView.addSubview(searchImageView)
        searchView.addSubview(searchLabel)
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
    
    // searchView
    lazy var searchView = { () -> UIView in
        var serchView = UIView()
        return serchView
        
    }()
    
    lazy var searchImageView = { () -> UIImageView in
        var view = UIImageView()
        view.image = UIImage(named: "searchBtnIcon")
        return view
        
    }()
    
    lazy var searchLabel = { () -> UILabel in
        var view = UILabel()
        view.textColor = UIColor.white
        view.textAlignment = .left
        view.font = UIFont.systemFont(ofSize: 13)
        view.text = ""
        return view
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

extension DYNavigationBar{
    func getTodayHot(_ completionHandler: @escaping ()->()) {
        let url = "https://apiv2.douyucdn.cn/live/search/getTodayHot?client_sys=ios"
        HttpTool.getRequest(url: url, completionHandler: { (result) in
            let data = result["data"] as! [[String:Any]]
            var temp = [String]()
            for v in data{
                let hot = v["kw"] as! String
                temp.append(hot)
            }
            self.hot = temp
            completionHandler()
        }) { (error) in
            print("err === \(error)")
        }
    }
    
    
}

extension DYNavigationBar{
    static var sharedNavigationBar : DYNavigationBar {
        struct Static {
            static let instance : DYNavigationBar = DYNavigationBar(frame: CGRect(x:0,y:0,width:KScreenWidth,height:KNavigationHeight))
        }
        return Static.instance
    }
}
