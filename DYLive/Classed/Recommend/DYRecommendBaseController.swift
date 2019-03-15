//
//  DYRecommendBaseController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
let KItemMargin :CGFloat = 5
let KNormalItemW :CGFloat = (KScreenWidth - KItemMargin)/2
let KNormalItemH :CGFloat = KNormalItemW * 9/16 + CGFloat(50)

let KNormalIdentifier = "KNormalIdentifier"
let KHeaderViewIdentifier = "KHeaderViewIdentifier"

enum RecommendScrollDirection :String {
    case up = "UP"
    case down = "DOWN"
}

class DYRecommendBaseController: UIViewController,UICollectionViewDelegate,UICollectionViewDataSource{
    
    var baseViews:[UIView] = [UIView]()
    var navgationBarHidden :Bool = false
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view = baseView
        baseView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalTo(self.view)
        }
        setupUI()
    }
    
    lazy var baseView : UIView = { [unowned self] in
        let view = UIView()
        view.backgroundColor = UIColor.yellow
        view.frame = self.view.bounds
        return view
    }()
    
    // lazy
    lazy var collectionView :UICollectionView = { [unowned self]  in
        let height = KScreenHeight - KNavigationHeight - KPageTitleHeight - KTabBarHeight
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.view.bounds,collectionViewLayout: layout)
        layout.itemSize = CGSize(width:KNormalItemW,height:KNormalItemH)
        layout.headerReferenceSize = CGSize(width:KScreenWidth,height:50)
        layout.minimumLineSpacing = 0//KItemMargin
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.bounces = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        
        
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        
        collectionView.register(UINib(nibName: "DYRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalIdentifier)
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
        return collectionView
        }()
    
    func setupUI(){
        view.addSubview(collectionView)
        print("DYRecommendBaseController \(self.view.frame)")
    }
}

extension DYRecommendBaseController{
    
}

extension DYRecommendBaseController {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        cell.backgroundColor = UIColor.random_color()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewIdentifier, for: indexPath) as! DYRecommendHeaderView
        
        return headerView
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
        
        let height = KScreenHeight - KNavigationHeight - KTabBarHeight
        if  velocity < -15 {
            navgationBarHidden = true
//            for view in baseViews{
//                view.frame = CGRect.make(0, -KPageTitleHeight/2, KScreenWidth, height)
//            }
            baseView.frame = CGRect.make(0, -KPageTitleHeight/2, KScreenWidth, height)
        }else if velocity > 15{
            navgationBarHidden = false
//            for view in baseViews{
//                view.frame = CGRect.make(0, 0, KScreenWidth, height - KPageTitleHeight)
//            }
            baseView.frame = CGRect.make(0, 0, KScreenWidth, height - KPageTitleHeight)
        }
        NotificationCenter.xsyPostNotification(postName: KRecommendContentScrollNotification, object: direction)
    }
}
