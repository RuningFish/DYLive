//
//  RecommendViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit


class DYRecommendViewController: DYBaseViewController {

    lazy var recomCateListVM :DYRecommendCateListViewModel = DYRecommendCateListViewModel()
    lazy var cateList :[String] = [String]()
    // 推荐页推荐滚动条
    lazy var pageTitle = { () -> DYPageTitleView in
        let titles :[String] = ["分类","推荐","全部","LOL","刺激战场","绝地求生","王者荣耀"]
        let view = DYPageTitleView(frame:CGRect.make(0, KNavigationHeight, KScreenWidth, KPageTitleHeight), titles:titles)
        return view
    }()
    
    // 推荐页推荐内容展示页
    lazy var pageContent = { () -> DYPageTitleContentView in
        var childVc = [UIViewController]()
        let classify  = DYClassify()
        let recommend = DYRecommend()
        childVc.append(classify)
        childVc.append(recommend)
        for _ in 0..<5{
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor.random_color()
            childVc.append(vc)
        }
        let contentView = DYPageTitleContentView(frame:CGRect.make(0, KNavigationHeight + 44, KScreenWidth, KScreenHeight - KNavigationHeight - KPageTitleHeight - KTabBarHeight),childVc:childVc, parentVc:self)
        return contentView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

//        view.addSubview(pageTitle)
//        view.bringSubview(toFront: pageTitle)
        view.addSubview(pageContent)
        pageTitle.delegate = self
        pageContent.delegate = self
        // Do any additional setup after loading the view.
        
        recomCateListVM.requestData {[unowned self] in
            var temp = ["分类","推荐","全部"]
            for model in self.recomCateListVM.cateListData{
                temp.append(model.cate_name!)
            }
            
            DispatchQueue.main.async {
                self.pageTitle = DYPageTitleView(frame:CGRect.make(0, KNavigationHeight, KScreenWidth, KPageTitleHeight), titles:temp)
                self.pageTitle.delegate = self
                self.view.addSubview(self.pageTitle)
                
//                print("请求完成了 ==== \(temp) page:")
            }
            
//            self.view.addSubview(self.pageTitle)
            
        }
        
        
        view.backgroundColor = UIColor.orange
        NotificationCenter.default.addObserver(self, selector: #selector(xxx), name:NSNotification.Name(rawValue: KRecommendContentScrollNotification) , object:nil)
    }

   @objc func xxx(noti:Notification) {
        guard let direction = noti.object as? RecommendScrollDirection else {return}
        if direction == .up {
            UIView.animate(withDuration: 0.2) {
                self.pageTitle.frame = CGRect.make(0, KStatusBarHeight, KScreenWidth, 44)
            }
            
            self.pageContent.frame = CGRect.make(0, KNavigationHeight , KScreenWidth, KScreenHeight - KNavigationHeight - KTabBarHeight )
            print("pageContrnt的高度 \(pageContent.frame.height)")
            dyNavBar.frame = CGRect.make(0, 0, KScreenWidth, KNavigationHeight)
            
            pageContent.setNeedsLayout()
            
//            self.navigationController.
        }else if direction == .down{
            UIView.animate(withDuration: 0.2) {
                self.pageTitle.frame = CGRect.make(0, KNavigationHeight, KScreenWidth, 44)
            }
            
            pageContent.frame = CGRect.make(0, KNavigationHeight + KStatusBarHeight, KScreenWidth, KScreenHeight - KNavigationHeight - KPageTitleHeight - KTabBarHeight)
        }
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
        pageTitle.updateTitleView(progress: progress, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}
