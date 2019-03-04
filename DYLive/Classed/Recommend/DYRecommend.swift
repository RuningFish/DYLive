//
//  DYRecommend.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
private let KItemMargin :CGFloat = 5
private let KNormalItemW :CGFloat = (KScreenWidth - KItemMargin)/2
private let KNormalItemH :CGFloat = KNormalItemW * 9/16 + CGFloat(50)

let KNormalIdentifier = "KNormalIdentifier"
let KHeaderViewIdentifier = "KHeaderViewIdentifier"

enum RecommendScrollDirection :String {
    case up = "UP"
    case down = "DOWN"
}

class DYRecommend: UIViewController,UICollectionViewDelegate {
    
    // 推荐页的数据源
    var recommendData  = [[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" DYRecommend")
        view.backgroundColor = UIColor.red
        
        setupUI()
        
    }
    
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
//        collectionView.autoresizingMask = [.flexibleWidth,.flexibleHeight]
        collectionView.register(UINib(nibName: "DYRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalIdentifier)
//        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
        
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
        
        return collectionView
    }()
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        collectionView.frame = view.bounds
        print("viewDidLayoutSubviews \(view.frame.height)")
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        print("viewWillLayoutSubviews")
        collectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
    }
    
    func loadData(){
        let url = "http:capi.douyucdn.cn/api/v1/getbigDataRoom"
        let param = ["client_sys" : "ios","time" : NSDate.getCurrentTime()]
        HttpTool.manager(method:RequestMethod.Get, url:url,param:param){(result) in
            //            print("\(result)")
            guard let response = result as? [String:Any] else{return}
            guard let data = response["data"] as? [[String:Any]] else {return}
            
            var normal = [DYRecommendNormal]()
            for dict in data{
                let dic = DYRecommendNormal(dict:dict)
                normal.append(dic)
            }
            
            self.recommendData.append(normal)
            self.collectionView.reloadData()
            
//            print("------\(self.recommendData)")
        }
    }
}

extension DYRecommend{
    func setupUI(){
        view.addSubview(collectionView)
        loadData()
    }
}

extension DYRecommend : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if recommendData.count == 0 {
            return 0
        }
        let normal = recommendData[section]
        return normal.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalIdentifier, for: indexPath) as! DYRecommendNormalCell
        let data = recommendData[indexPath.section]
        let model = data[indexPath.item] as! DYRecommendNormal
        cell.normalModel = model
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewIdentifier, for: indexPath) as! DYRecommendHeaderView
        
        return headerView
    }
}

extension DYRecommend :UIScrollViewDelegate{
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print("-------------------> scrollViewDidScroll")
        let contentOffsetY = scrollView.contentOffset.y
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DYRecommendNotification"), object: contentOffsetY)
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pan = scrollView.panGestureRecognizer
        let velocity = pan.velocity(in: scrollView).y
        let direction :RecommendScrollDirection = (velocity < -15) ?.up:.down
        
        let height = KScreenHeight - KNavigationHeight - KPageTitleHeight - KTabBarHeight
        if  velocity < -15 {
            self.view.frame = CGRect.make(0, -22, KScreenWidth, 641)
        }else if velocity > 15{
            self.view.frame = CGRect.make(0, 0, KScreenWidth, 597)
        }
        NotificationCenter.xsyPostNotification(postName: KRecommendContentScrollNotification, object: direction)
    }
}
