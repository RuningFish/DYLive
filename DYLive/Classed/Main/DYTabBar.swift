//
//  DYTabBar.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
protocol DYTabBarDelegate {
    func tabBarDidSelect(tabBar:DYTabBar,fromIndex:Int,toIndex:Int)
}

class DYTabBar: UITabBar {

    var myDelegate: DYTabBarDelegate?
    private var tabbarItems = [DYTabBarItem]()
    private var lastItem :DYTabBarItem?
    private let tabTitles = ["推荐","娱乐","关注","鱼塘","发现"]
    private let tabIcons  = ["tabLive","tabYule","tabFocus","tabYuba","tabDiscovery"]
    private let tabGifs = ["gif_tabLive.gif","gif_tabYule.gif","gif_tabFocus.gif","gif_tabYuba.gif","gif_tabDiscovery.gif"]
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.make(0, 0, KScreenWidth, 49)
        self.backgroundColor = UIColor.red
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}

extension DYTabBar{
    func setupUI(){
        print("my --- tabbar")
        let y :CGFloat = 0
        let w :CGFloat = self.frame.width/CGFloat(tabTitles.count)
        let h :CGFloat = 49//self.frame.height
        for (index,value) in tabTitles.enumerated(){
            let x = CGFloat(index) * w
            let tabBarItem = DYTabBarItem(frame:CGRect.make(x, y, w, h))
            tabBarItem.tag = index
            if index == 0{
                tabBarItem.selected = true
                tabBarItem.tabBarTitle.textColor = UIColor.orange
                lastItem = tabBarItem
            }else{
                tabBarItem.tabBarTitle.textColor = UIColor.lightGray
            }
            tabBarItem.tabBarIcon.image = UIImage(named:tabIcons[index])
            tabBarItem.tabBarIconHigh.image = UIImage(named:"\(tabIcons[index])\("HL")")
            tabBarItem.tabBarTitle.text = value
            let tap = UITapGestureRecognizer.init(target: self, action: #selector(tabBarItemClick))
            tabBarItem.addGestureRecognizer(tap)
            self.addSubview(tabBarItem)
            self.tabbarItems.append(tabBarItem)
        }
        
    }
}

extension DYTabBar{
    @objc func tabBarItemClick(tap:UITapGestureRecognizer) {
        guard let currentItem = tap.view as? DYTabBarItem else {return}
        let selectIndex = currentItem.tag
//        guard let oldItem = lastItem else {return}
        if lastItem?.tag == currentItem.tag {return}
        // 停止旧动画
        lastItem?.stopAtOnce()
        print("\(lastItem?.tag)  \(selectIndex)")
        for item in tabbarItems{
            item.selected = false
            item.stop = true
        }
        currentItem.selected = true
        currentItem.stop = false
        // 设置title
        currentItem.tabBarTitle.textColor = UIColor.orange
        lastItem?.tabBarTitle.textColor = UIColor.lightGray
        // delegate
        myDelegate?.tabBarDidSelect(tabBar: self, fromIndex: (lastItem?.tag)!, toIndex: selectIndex)
        // 更新lastItem
        lastItem = currentItem
        
        // gif
        let path = Bundle.main.path(forResource: "\(tabGifs[selectIndex])", ofType: nil)
        currentItem.startAnimating(path: path!)
        let time :TimeInterval = 1.8
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + time, execute: {
            currentItem.stopAnimating()
        })
    }
}
