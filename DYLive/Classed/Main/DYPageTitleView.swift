//
//  DYPageTitleView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/1.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
protocol DYPageTitleViewDelegate: class {
    func pageTitleView(titleView: DYPageTitleView, selectIndex:Int)
}

class DYPageTitleView: UIView {

    var titles :[String]
    // 保存label的数组
    var labels = [UILabel]()
    // 保存上一次点击label的下标
    var current : Int = 0
    var delegate: DYPageTitleViewDelegate?
    init(frame: CGRect, titles:[String]) {
        self.titles = titles
        super.init(frame: frame)
        setUpUI()
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // lazy
    lazy var scrollowView = { () -> UIScrollView in
        let scrollow = UIScrollView()
        scrollow.frame = CGRect.make(0, 0, KScreenWidth, KPageTitleHeight)
        scrollow.isPagingEnabled = false
        scrollow.showsHorizontalScrollIndicator = false
        scrollow.showsVerticalScrollIndicator = false
        scrollow.bounces = false
        return scrollow
    }()
}

extension DYPageTitleView{
    
    private func setUpUI(){
        addSubview(scrollowView)
        
        addTitleLabels()
        backgroundColor = UIColor.orange
        // 默认选中推荐
        let recommendLab = labels[1]
        recommendLab.font = UIFont(name: "PingFangSC-Medium", size: 15)
    }
    
    private func addTitleLabels() {
        let count :  CGFloat = 5
        let labelY : CGFloat = 0
        let labelW : CGFloat = frame.size.width / count
        let labelH : CGFloat = KPageTitleHeight
        
        for (index,value) in titles.enumerated() {
            let label = UILabel()
            let labelX : CGFloat = CGFloat(index) * labelW
            label.frame = CGRect.make(labelX,labelY,labelW,labelH) 
            label.text = value
            label.textAlignment = NSTextAlignment.center
            label.textColor = UIColor.white
            label.tag = index
            label.font = UIFont(name: "PingFangSC-Light", size: 14)
            label.isUserInteractionEnabled = true
            let tap = UITapGestureRecognizer(target:self ,action:#selector(pageTitleClick))
            label.addGestureRecognizer(tap)
            scrollowView.addSubview(label)
            labels.append(label)
        }
        
        // 滚动的范围
        scrollowView.contentSize = CGSize(width:labelW * CGFloat(titles.count),height:0)
    }
    
    @objc private func pageTitleClick(tap: UITapGestureRecognizer){
        // 获取当前点击的label
        guard let newLabel = tap.view as? UILabel else{
            return
        }
        // 处理点击同一个label改变的问题
        if current == newLabel.tag {
            return
        }
        // 修改当前label的字体
        newLabel.font = UIFont(name: "PingFangSC-Medium", size: 15)
        // 还原之前label的字体样式
        let oldLabel = labels[current]
        oldLabel.font = UIFont(name: "PingFangSC-Light", size: 14)
        // 更新currentIndex
        current = newLabel.tag
        // 滚动
//        let w = KScreenHeight/6.0
//        scrollowView.scrollRectToVisible(CGRect.make(130, 0, KScreenWidth, 44), animated: true)
        
        // 通知代理
        self.delegate?.pageTitleView(titleView: self, selectIndex: newLabel.tag)
        print("---------")
    }
}

// 对外暴露的方法
extension DYPageTitleView{
    // 更新滚动条的字体
    func updateTitleView(progress: CGFloat, currentIndex: Int, targetIndex: Int){
        let currentLbael = labels[currentIndex]
        let targetLabel  = labels[targetIndex]
        if progress == 1.0 || progress == 0{
            targetLabel.font = UIFont(name: "PingFangSC-Medium", size: 15)
        }else if progress > 0.20 || progress < 0.20{
            currentLbael.font = UIFont(name: "PingFangSC-Light", size: 15)
        }
        
        current = targetIndex
//        print("\(progress)")
//            currentLabel.font = UIFont(name: "PingFangSC-Light", size: 14)
//            currentLabel.font = UIFont(name: "PingFangSC-Medium", size: 15)
        
    }
}
