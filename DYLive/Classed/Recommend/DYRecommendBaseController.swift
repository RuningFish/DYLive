//
//  DYRecommendBaseController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
//private let KItemMargin :CGFloat = 5
//private let KNormalItemW :CGFloat = (KScreenWidth - KItemMargin)/2
//private let KNormalItemH :CGFloat = KNormalItemW * 9/16 + CGFloat(50)
//
//let KNormalIdentifier = "KNormalIdentifier"
//let KHeaderViewIdentifier = "KHeaderViewIdentifier"
//
//enum RecommendScrollDirection :String {
//    case up = "UP"
//    case down = "DOWN"
//}

class DYRecommendBaseController: UIViewController,UICollectionViewDelegate {
    
    // 自定义导航栏
    lazy var dyNavBar = { () -> DYNavigationBar in
        let navBar = DYNavigationBar()
        navBar.frame = CGRect(x:0,y:0,width:KScreenWidth,height:KNavigationHeight)
        navBar.backgroundColor = UIColor.orange
        return navBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dyNavBar)
    }
    
    // lazy
//    lazy var collectionView :UICollectionView = { [unowned self]  in
//        let height = KScreenHeight - KNavigationHeight - KPageTitleHeight - KTabBarHeight
//        let layout = UICollectionViewFlowLayout()
//        let collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout: layout)
//        layout.itemSize = CGSize(width:KNormalItemW,height:KNormalItemH)
//        layout.headerReferenceSize = CGSize(width:KScreenWidth,height:50)
//        layout.minimumLineSpacing = 0//KItemMargin
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .vertical
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.showsVerticalScrollIndicator = false
//        collectionView.isPagingEnabled = false
//        collectionView.bounces = false
//        collectionView.dataSource = self
//        collectionView.delegate = self
//        collectionView.backgroundColor = UIColor.white
//        //        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
//        
//        
//        collectionView.register(UINib(nibName: "DYRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalIdentifier)
//        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
//        return collectionView
//        }()
}

extension DYRecommendBaseController{
    private func setupUI(){
//        view.addSubview(collectionView)
    }
}

extension DYRecommendBaseController :UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let contentOffsetY = scrollView.contentOffset.y
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DYRecommendNotification"), object: contentOffsetY)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        let direction :RecommendScrollDirection = (velocity < -15) ?.up:.down
        
        if  velocity < -15 {
            self.view.frame = CGRect.make(0, -22, KScreenWidth, 641)
        }else if velocity > 15{
            self.view.frame = CGRect.make(0, 0, KScreenWidth, 597)
        }
        NotificationCenter.xsyPostNotification(postName: KRecommendContentScrollNotification, object: direction)
    }
}
