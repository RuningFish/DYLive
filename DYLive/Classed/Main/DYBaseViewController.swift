//
//  DYBaseViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/4.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYBaseViewController: UIViewController {
    // 自定义导航栏
    lazy var dyNavBar = { () -> DYNavigationBar in
        let navBar = DYNavigationBar()
        navBar.frame = CGRect(x:0,y:0,width:KScreenWidth,height:KNavigationHeight)
        navBar.backgroundColor = UIColor.orange
        return navBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(dyNavBar)
        view.backgroundColor = UIColor.orange
        
        
    }
}

extension DYBaseViewController{
    private func setupUI(){
        //        view.addSubview(collectionView)
    }
}
