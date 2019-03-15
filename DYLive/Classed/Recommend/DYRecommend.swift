//
//  DYRecommend.swift
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
let KRecommondBeautyIdentifier = "KRecommondBeautyIdentifier"
class DYRecommend: DYRecommendBaseController {
    
    // 推荐页的数据源
    var recommendData  = [[Any]]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(" DYRecommend")
        view.backgroundColor = UIColor.red
        baseViews.append(view)
//        setupUI()
        view.addSubview(live_video_start)
        addConstraints()
        loadData()
        
        collectionView.register(UINib(nibName: "DYRecommendNormalCell", bundle: nil), forCellWithReuseIdentifier: KNormalIdentifier)
        collectionView.register(UINib(nibName: "DYRecommendBeautyCell", bundle: nil), forCellWithReuseIdentifier: KRecommondBeautyIdentifier)
        collectionView.register(UINib(nibName: "DYRecommendHeaderView", bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: KHeaderViewIdentifier)
        
    }
    
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
    
    lazy var live_video_start :UIButton = {
        let view = UIButton()
        view.setImage(UIImage(named:"btn_livevideo_start_home"), for:.normal)
        view.addTarget(self, action: #selector(didClickStartLiveVideo(_:)), for: .touchUpInside)
        return view
    }()
    
    func loadData(){
        let url = "http:capi.douyucdn.cn/api/v1/getbigDataRoom"
        let param = ["client_sys" : "ios","time" : NSDate.getCurrentTime()]
        
        let group = DispatchGroup()
        group.enter()
        var normal = [DYRecommendNormal]()
        HttpTool.manager(method:RequestMethod.Get, url:url,param:param){(result) in
            //            print("\(result)")
            guard let response = result as? [String:Any] else{return}
            guard let data = response["data"] as? [[String:Any]] else {return}
            
            for dict in data{
                let dic = DYRecommendNormal(dict:dict)
                normal.append(dic)
            }
            group.leave()
            
        }
        
        var beauty = [DYRecommendBeautyModel]()
        let parameters = ["limit" : "8", "offset" : "0","client_sys" : "ios", "time" : NSDate.getCurrentTime()]
        group.enter()
        HttpTool.manager(method:RequestMethod.Get, url: "http://capi.douyucdn.cn/api/v1/getVerticalRoom", param: parameters) { (result) in
            guard let response = result as? [String : Any] else { return }
            guard let data = response["data"] as? [[String : Any]] else { return }
            
            for dict in data {
                let model = DYRecommendBeautyModel(dict: dict)
                beauty.append(model)
            }
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            self.recommendData.append(normal)
            self.recommendData.append(beauty)
            self.collectionView.reloadData()
        }
    }
}

extension DYRecommend{
     func addConstraints(){
        
        live_video_start.snp.makeConstraints { (make) in
            make.right.equalTo(-20)
            make.bottom.equalTo(-30)
            make.width.height.equalTo(70)
        }
    }
    
   @objc func didClickStartLiveVideo(_ button:UIButton){
        self.present(DYShowLiveController(), animated: false, completion: nil)
    }
}

extension DYRecommend {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return recommendData.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        let normal = recommendData[section]
        return normal.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.section == 0{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KNormalIdentifier, for: indexPath) as! DYRecommendNormalCell
            let data = recommendData[indexPath.section]
            let model = data[indexPath.item] as! DYRecommendNormal
            cell.normalModel = model
            return cell
        }else if indexPath.section == 1{
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: KRecommondBeautyIdentifier, for: indexPath) as! DYRecommendBeautyCell
            let data = recommendData[indexPath.section]
            let beauty = data[indexPath.item] as! DYRecommendBeautyModel
            cell.beauty = beauty
            return cell
        }
        
        return UICollectionViewCell()
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: KHeaderViewIdentifier, for: indexPath) as! DYRecommendHeaderView
        
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let startLive = DYStartLiveViewController()
        startLive.view.backgroundColor = UIColor.white
        self.navigationController?.pushViewController(startLive, animated: true)
    }
}

extension DYRecommend :UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.section == 0{
            return CGSize(width:KNormalItemW,height:KNormalItemH)
        }else if indexPath.section == 1{
            return CGSize(width:KNormalItemW,height:KNormalItemW)
        }
        return CGSize(width:KNormalItemW,height:KNormalItemH)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        if  section == 0 {
            return KItemMargin
        }else if section == 1{
            return KItemMargin
        }
        return KItemMargin
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        if section == 1 {
            return KItemMargin
        }
        return 0
    }
    
//    override func scrollViewDidScroll(_ scrollView: UIScrollView) {
////        print("-------------------> scrollViewDidScroll")
//        let contentOffsetY = scrollView.contentOffset.y
//        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "DYRecommendNotification"), object: contentOffsetY)
//    }
//
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        UIView.animate(withDuration: 0.5, animations: {
            self.live_video_start.isHidden = true
        })
    }
    
    override func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        super.scrollViewWillEndDragging(scrollView, withVelocity: velocity, targetContentOffset: targetContentOffset)
        if !navgationBarHidden {
            UIView.animate(withDuration: 0.5, animations: {
                self.live_video_start.isHidden = false
            })
        }
    }
}
