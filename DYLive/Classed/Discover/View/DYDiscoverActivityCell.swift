//
//  DYDiscoverActivityCell.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

private let KActivityCell = "DYDiscoverActivityCell"

class DYDiscoverActivityCell: UICollectionViewCell,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var listData:[DYRecommendBaseModel]? {
        didSet{
            collectionView.reloadData()
        }
    }
    var target:UIViewController?
    override init(frame: CGRect) {
        super.init(frame: frame)
        contentView.addSubview(collectionView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    lazy var collectionView :UICollectionView = { [unowned self]  in
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.bounds,collectionViewLayout: layout)
        layout.itemSize = CGSize(width:205,height:118)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.bounces = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(0, 10, 0, 10)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: KActivityCell)
        return collectionView
    }()
}

extension DYDiscoverActivityCell{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return listData?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KActivityCell, for: indexPath)
        for v in cell.contentView.subviews{
            v.removeFromSuperview()
        }
        let activity = UIImageView()
        activity.frame = cell.bounds
        cell.contentView.addSubview(activity)
        let act_pic = listData![indexPath.item].act_pic
        activity.kf.setImage(with: URL(string: act_pic))
        cell.backgroundColor = UIColor.random_color()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let act_link = listData![indexPath.item].act_link
        if act_link.hasPrefix("http") || act_link.hasPrefix("https"){
            let webView = DYWebViewController()
            webView.url = act_link
            target?.navigationController?.pushViewController(webView, animated: true)
            
        }
        print("link === \(act_link)")
    }
}
