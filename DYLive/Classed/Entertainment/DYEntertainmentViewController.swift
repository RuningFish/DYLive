//
//  EntertainmentViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYEntertainmentViewController: DYBaseViewController,UICollectionViewDelegate,UICollectionViewDataSource {
   
    lazy var enterTainmentVM:DYDYEntertainmentViewModel = DYDYEntertainmentViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        
        enterTainmentVM.requestData {
            DispatchQueue.main.async {
//                print(" entertainment \(self.enterTainmentVM.data)")
                self.collectionView.reloadData()
            }
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
        
        collectionView.register(UINib(nibName: "DYRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalIdentifier)
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
        return collectionView
        }()
    
    func setupUI(){
        view.addSubview(collectionView)
    }
}

extension DYEntertainmentViewController{
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return enterTainmentVM.group.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return enterTainmentVM.group[section].count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalIdentifier, for: indexPath) as! DYRecommendNormalCell
        let data = enterTainmentVM.group[indexPath.section]
        let model = data[indexPath.item] as! DYEntertainmentModel
        cell.normalModel = enterTainmentVM.changeModel(model: model)
        var text = ""
        if model.anchor_label!.count > 0{
            var txt0 = model.anchor_label![0]["tag"] as! String
            var txt1 = ""
            var txt2 = ""
            text = "\(txt0) >"
            if model.anchor_label!.count > 1{
                txt1 = model.anchor_label![1]["tag"] as! String
                text = "\(txt0) > \(txt1)"
            }else if model.anchor_label!.count > 2{
                txt0 = model.anchor_label![0]["tag"] as! String
                txt1 = model.anchor_label![1]["tag"] as! String
                txt2 = model.anchor_label![2]["tag"] as! String
                text = "\(txt0) > \(txt1) > \(txt2)"
            }
            
            cell.type.text = text
        }else{
            cell.type.text = "暂无标签 >"
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewIdentifier, for: indexPath) as! DYRecommendHeaderView
        headerView.hotLabel.text = "户外"
        return headerView
    }
}
