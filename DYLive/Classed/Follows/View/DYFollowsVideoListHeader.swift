//
//  DYFollowsVideoListHeader.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit
private let KFollowsVideoListHeaderCell = "FollowsVideoListHeaderCell"
class DYFollowsVideoListHeader: UIView,UICollectionViewDelegate,UICollectionViewDataSource {

    lazy var videoHeaderUpList:[DYFollowsVideoHeaderModel] = [DYFollowsVideoHeaderModel]()
    override init(frame: CGRect) {
        super.init(frame:frame)
        setupUI()
    }
    
    private lazy var collectionView :UICollectionView = { () in
        let flowLayout = UICollectionViewFlowLayout()
        let margin :CGFloat = 10
        flowLayout.minimumLineSpacing = margin
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: 150, height: 150)
        let collectionView = UICollectionView(frame: CGRect.zero, collectionViewLayout: flowLayout)
        collectionView.collectionViewLayout = flowLayout
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.contentInset = UIEdgeInsetsMake(0, margin/2, 0, margin/2)
        collectionView.register(DYFollowsHeaderUPCell.self, forCellWithReuseIdentifier: KFollowsVideoListHeaderCell)
        collectionView.backgroundColor = .white
        return collectionView
    }()
    
    private lazy var label_1 :UILabel = { () in
        let view = UILabel()
        view.font = UIFont(name: Helvetica_Bold, size: 17)
        view.textColor = UIColor.black
        view.textAlignment = .left
        view.text = "优质UP主推荐"
        return view
    }()
    
    private lazy var label_2 :UILabel = { () in
        let view = UILabel()
        view.font = UIFont(name: Helvetica_Bold, size: 17)
        view.textColor = UIColor.black
        view.textAlignment = .left
        view.text = "最热视频推荐"
        return view
    }()
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        
    }
    
    func reloadData(){
        collectionView.reloadData()
    }
    
    func setupUI() {
        addSubview(label_1)
        addSubview(collectionView)
        addSubview(label_2)
        
        label_1.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.top.right.equalToSuperview().offset(0)
            make.height.equalTo(30)
        }
        
        label_2.snp.makeConstraints { (make) in
            make.left.right.equalTo(label_1).offset(0)
            make.bottom.equalToSuperview().offset(-10)
            make.height.equalTo(30)
        }
        
        collectionView.snp.makeConstraints { (make) in
            make.left.right.equalToSuperview().offset(0)
            make.top.equalTo(label_1.snp.bottom).offset(0)
            make.bottom.equalTo(label_2.snp.top).offset(0)
        }
    }
}

extension DYFollowsVideoListHeader{
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return videoHeaderUpList.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KFollowsVideoListHeaderCell, for: indexPath) as! DYFollowsHeaderUPCell
        cell.upModel = videoHeaderUpList[indexPath.item]
        cell.backgroundColor = UIColor.white
        return cell
    }
}
