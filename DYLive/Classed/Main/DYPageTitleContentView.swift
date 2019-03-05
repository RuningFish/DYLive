//
//  DYPageTitleContentView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/1.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

protocol DYPageTitleContentViewDelegate:class {
    func pageTitleContentViewDidScroll(pageTitleView:DYPageTitleContentView, progress:CGFloat,currentIndex:Int,targetIndex:Int)
}

let Identifier = "Identifier"
class DYPageTitleContentView: UIView,UICollectionViewDelegate {

    var delegate: DYPageTitleContentViewDelegate?
    var childVc :[UIViewController]
    var parentVc : UIViewController
    private var forbid :Bool = false
    // 起始的拖动偏移
    private var startOffsetX :CGFloat = 0
    init(frame: CGRect, childVc:[UIViewController], parentVc:UIViewController) {
        self.childVc = childVc
        self.parentVc = parentVc
        super.init(frame: frame)
        
        setupUI()
        backgroundColor = UIColor.green
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // lazy
    lazy var collectionView :UICollectionView = { [unowned self] in
        // CGRect.make(0, 0, KScreenWidth,KScreenHeight - KNavigationHeight - KPageTitleHeight - KTabBarHeight)
        let layout = UICollectionViewFlowLayout()
        let collectionView = UICollectionView(frame: self.bounds,collectionViewLayout: layout)
        layout.itemSize = CGSize(width:KScreenWidth,height:self.frame.size.height)
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: Identifier)
        return collectionView
    }()
    
    override func layoutSubviews() {
        super.layoutSubviews()
        collectionView.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        print("DYPageTitleContentView ---> layoutSubviews \(self.bounds)")
        
    }
}

extension DYPageTitleContentView {
    func setupUI() {
        
        for vc in childVc {
            parentVc.addChildViewController(vc)
        }
        
        addSubview(collectionView)
        collectionView.frame = bounds
        
        // 设置范围
        setContentOffset(selectIndex: 1)
    }
}

extension DYPageTitleContentView : UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVc.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Identifier, for: indexPath)
        
        for view in cell.contentView.subviews{
            view.removeFromSuperview()
        }
        
        let vc = childVc[indexPath.item]
//        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        vc.view.snp.makeConstraints { (make) in
            make.top.left.bottom.right.equalToSuperview()
        }
        
        return cell
    }
    
}

extension DYPageTitleContentView {
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        forbid = false
        startOffsetX = scrollView.contentOffset.x
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if forbid {return}
        let x :CGFloat = scrollView.panGestureRecognizer.translation(in: scrollView).x
        let contentOffsetX = scrollView.contentOffset.x
        var progress:CGFloat = 0.0
        // 当前所在的位置
        var currentIndex :Int = 0
        // 将要移动到的位置
        var targetIndex :Int = 0
        if x > 0{ // 左滑
            progress = 1 - (contentOffsetX/KScreenWidth - floor(contentOffsetX/KScreenWidth))
            targetIndex = Int(contentOffsetX/KScreenWidth)
            currentIndex = targetIndex + 1
            if currentIndex >= childVc.count{
                currentIndex = childVc.count - 1
            }
            if startOffsetX - contentOffsetX == KScreenWidth{
                progress = 1
                currentIndex = targetIndex
            }else if startOffsetX == contentOffsetX{
                progress = 0
                currentIndex = targetIndex
            }
        }else{// 右滑
            progress = contentOffsetX/KScreenWidth - floor(contentOffsetX/KScreenWidth)
            currentIndex = Int(contentOffsetX/KScreenWidth)
            targetIndex = currentIndex + 1
            if targetIndex >= childVc.count{
                targetIndex = childVc.count - 1
            }
            if contentOffsetX - startOffsetX == KScreenWidth{
                progress = 1
                targetIndex = currentIndex
            }else if contentOffsetX == startOffsetX {
                targetIndex = currentIndex
            }
        }
        
        
//        print("progress :\(progress) \("currentIndex:") \(currentIndex)  \("targetIndex:") \(targetIndex)")
        delegate?.pageTitleContentViewDidScroll(pageTitleView: self, progress: progress, currentIndex: currentIndex, targetIndex: targetIndex)
    }
}

extension DYPageTitleContentView{
    // 设置滚动范围
    func setContentOffset(selectIndex:Int){
        forbid = true
        let contentOffsetX = CGFloat(selectIndex) * KScreenWidth
        collectionView.setContentOffset(CGPoint(x:contentOffsetX,y:0), animated: false)
    }
}
