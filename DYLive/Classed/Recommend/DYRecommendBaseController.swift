//
//  DYRecommendBaseController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYRecommendBaseController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // lazy
    lazy var collectionView = {() -> UICollectionView in
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.make(0, 0, KScreenHeight,KScreenHeight),collectionViewLayout: layout)
//        layout.itemSize = CGSize(width:KScreenWidth,height:self.frame.size.height)
//        layout.minimumLineSpacing = 0
//        layout.minimumInteritemSpacing = 0
//        layout.scrollDirection = .horizontal
//        collectionView.showsHorizontalScrollIndicator = false
//        collectionView.isPagingEnabled = true
//        collectionView.bounces = false
//        collectionView.delegate = self as! UICollectionViewDelegate
//        collectionView.dataSource = self
//        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Identifier)
        return collectionView
    }()
}

extension DYRecommendBaseController{
    private func setupUI(){
        view.addSubview(collectionView)
    }
}
