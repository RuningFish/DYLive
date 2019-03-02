//
//  RecommendViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYRecommendViewController: UIViewController {

    // 推荐页推荐滚动条
    lazy var pageTitle = { () -> DYPageTitleView in
        let titles :[String] = ["分类","推荐","全部","LOL","刺激战场","绝地求生","王者荣耀"]
        let view = DYPageTitleView(frame:CGRect.make(0, KNavigationHeight, KScreenWidth, KPageTitleHeight), titles:titles)
        return view
    }()
    
    // 推荐页推荐内容展示页
    lazy var pageContent = { () -> DYPageTitleContentView in
        var childVc = [UIViewController]()
        for _ in 0..<7{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.random_color()
            childVc.append(vc)
        }
        let contentView = DYPageTitleContentView(frame:CGRect.make(0, KNavigationHeight + KStatusBarHeight, KScreenWidth, KScreenHeight - KNavigationHeight - KPageTitleHeight),childVc:childVc, parentVc:self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(pageTitle)
        view.addSubview(pageContent)
        pageTitle.delegate = self
        pageContent.delegate = self
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension DYRecommendViewController: DYPageTitleViewDelegate{
    func pageTitleView(titleView: DYPageTitleView, selectIndex: Int) {
        print("\(selectIndex)")
        pageContent.setContentOffset(selectIndex: selectIndex)
    }
}

extension DYRecommendViewController: DYPageTitleContentViewDelegate{
    func pageTitleContentViewDidScroll(pageTitleView: DYPageTitleContentView, progress: CGFloat, currentIndex: Int, targetIndex: Int) {
        print("DYPageTitleContentViewDelegate")
        pageTitle.updateTitleView(progress: progress, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}
