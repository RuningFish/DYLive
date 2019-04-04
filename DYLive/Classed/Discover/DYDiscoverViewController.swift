//
//  DiscoverViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import IJKMediaFramework
class DYDiscoverViewController: DYBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
    
    var discoverVM:DYDiscoverViewModel = DYDiscoverViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()
        discoverVM.requestData{
            self.collectionView.reloadData()
        }
    }
    
    
    lazy var collectionView :UICollectionView = { [unowned self]  in
        let height = KScreenHeight - KNavigationHeight - KTabBarHeight
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.make(0, KNavigationHeight, KScreenWidth, height),collectionViewLayout: layout)
        layout.itemSize = CGSize(width:KNormalItemW,height:KNormalItemH)
        layout.headerReferenceSize = CGSize(width:KScreenWidth,height:50)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .vertical
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.isPagingEnabled = false
        collectionView.bounces = true
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, 50, 0)
        collectionView.register(UINib(nibName: "DYRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalIdentifier)
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
        collectionView.register(DYDiscoverActivityCell.self, forCellWithReuseIdentifier: "cell")
        return collectionView
        }()
    
    func setupUI(){
        view.addSubview(collectionView)
    }
    
    private lazy var pauseButton :UIButton = {
        let view = UIButton.init(type: .custom)
        return view
    }()
    
    @objc func buttonClick(_ button:UIButton){
    }
    
    private func playVideoWithURL(url :String?) {
    }
}

extension DYDiscoverViewController {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return discoverVM.baseGroup.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let tag_name = discoverVM.baseGroup[section].tag_name
        let num = tag_name == "活动" ? 1:discoverVM.baseGroup[section].list.count
        return num
    }
    
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let tag_name = discoverVM.baseGroup[indexPath.section].tag_name
        if (tag_name == "语音直播" || tag_name == "热门视频") {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalIdentifier, for: indexPath) as! DYRecommendNormalCell
            let group = discoverVM.baseGroup[indexPath.section]
            let normal = group.list[indexPath.item] as! DYRecommendNormal
            cell.normalModel = normal
            cell.backgroundColor = UIColor.white
            return cell
        }else if tag_name == "活动"{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! DYDiscoverActivityCell
            cell.listData = discoverVM.baseGroup[indexPath.section].list
            cell.target = self
            return cell
        }
    
        return UICollectionViewCell()
    }
    
   func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewIdentifier, for: indexPath) as! DYRecommendHeaderView
        headerView.hotLabel.text = discoverVM.baseGroup[indexPath.section].tag_name
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        let startLive = DYPlayerBackController()//DYStartLiveViewController()
//        startLive.view.backgroundColor = UIColor.white
//        self.navigationController?.pushViewController(startLive, animated: true)
    }
}

extension DYDiscoverViewController:UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let tag_name = discoverVM.baseGroup[indexPath.section].tag_name
        if tag_name == "活动"{
            return CGSize(width:KScreenWidth,height:120)
        }else{
            return CGSize(width:KNormalItemW,height:KNormalItemW)
        }
    }
}
