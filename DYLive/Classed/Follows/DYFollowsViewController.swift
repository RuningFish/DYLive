//
//  FollowsViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
private let KSegmentViewH :CGFloat = 50
private let KDYFollowsVideoCell = "DYFollowsVideoCell"
class DYFollowsViewController: DYBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource,UITableViewDataSource,UITableViewDelegate {
    
    private lazy var followVM:DYFollowsViewModel = DYFollowsViewModel()
    private var selectItem :UIButton?
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        followVM.requestData {
            DispatchQueue.main.async {
                self.collectionView.reloadData()
            }
        }
    }
    
    lazy var collectionView :UICollectionView = { [unowned self]  in
        let height = KScreenHeight - KNavigationHeight - KTabBarHeight - KSegmentViewH
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: CGRect.make(0, KNavigationHeight + KSegmentViewH, KScreenWidth, height),collectionViewLayout: layout)
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
        
        collectionView.register(UINib(nibName: "DYRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalIdentifier)
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
        return collectionView
        }()
    
    lazy var segmentView : UIView = { () in
        let view = UIView()
        view.frame = CGRect.make(0, KNavigationHeight, KScreenWidth, KSegmentViewH)
        let btnW = KScreenWidth/4
        let seg = ["直播","视频"]
        for (i,v) in seg.enumerated(){
            let btn = UIButton.init(type: .custom)
            let btnX = CGFloat(i)*btnW
            btn.frame = CGRect.make(btnX, 0, btnW, KSegmentViewH)
            btn.setTitle(v, for: .normal)
            btn.tag = i
            btn.titleLabel?.font = UIFont(name:Helvetica_Bold,size: 17)
            view.addSubview(btn)
            btn.setTitleColor(UIColor.black, for: .normal)
            if i == 0{
                self.selectItem = btn
                btn.setTitleColor(UIColor.orange, for: .normal)
            }
            btn.addTarget(self, action: #selector(segmentClick(_:)), for: .touchUpInside)
        }
        view.backgroundColor = UIColor.white
        return view
    }()
    
    @objc private func segmentClick(_ button:UIButton){
        if selectItem?.tag == button.tag {return}
        button.setTitleColor(UIColor.orange, for: .normal)
        selectItem?.setTitleColor(UIColor.black, for: .normal)
        selectItem = button
        
        if button.tag == 0{
            view.insertSubview(tableView, belowSubview: collectionView)
        }else if button.tag == 1{
            if view.subviews.contains(tableView) == false{
                view.addSubview(tableView)
                followVM.getVideoList {
                    DispatchQueue.main.async {
                        self.tableView.reloadData()
                    }
                }
                
                followVM.getVideoHeaderList {
                    DispatchQueue.main.async { [unowned self] in
                        self.headerView.videoHeaderUpList = self.followVM.videoHeaderUp
                        self.headerView.reloadData()
                    }
                }
            }
            view.insertSubview(collectionView, belowSubview: tableView)
        }
    }
    
    lazy var tableView :UITableView = { [unowned self]  in
        let height = KScreenHeight - KNavigationHeight - KTabBarHeight - KSegmentViewH
        let view = UITableView.init(frame: CGRect.make(0, KNavigationHeight + KSegmentViewH, KScreenWidth, height), style: .plain)
        view.dataSource = self
        view.delegate = self
        view.backgroundColor = UIColor.white
        view.separatorStyle = .none
        view.rowHeight = KScreenWidth/16*9 + 50
        view.register(DYFollowsVideoCell.self, forCellReuseIdentifier: KDYFollowsVideoCell)
        view.tableHeaderView = headerView
        return view
        }()
    
    lazy var headerView: DYFollowsVideoListHeader = { () in
        let view = DYFollowsVideoListHeader(frame: CGRect.make(0, 0, KScreenWidth, 220))
        return view
    }()
    
    func setupUI(){
        view.addSubview(segmentView)
        view.addSubview(collectionView)
//        view.addSubview(tableView)
        
    }
}

extension DYFollowsViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return followVM.data.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return followVM.data[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalIdentifier, for: indexPath) as! DYRecommendNormalCell
        let data = followVM.data[indexPath.section]
        let model = data[indexPath.item] as! DYFollowsModel
        cell.normalModel = followVM.changeModel(model: model)
        cell.type.isHidden = true 
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewIdentifier, for: indexPath) as! DYRecommendHeaderView
        headerView.hotLabel.text = "可能认识的人"
        return headerView
    }
}

extension DYFollowsViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return followVM.videoList.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return followVM.videoList[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier:KDYFollowsVideoCell, for: indexPath) as! DYFollowsVideoCell
        let videoList = followVM.videoList[indexPath.section]
        cell.videoModel = videoList[indexPath.item] 
        cell.backgroundColor = UIColor.white
        return cell
    }
    
}
