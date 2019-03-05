//
//  DYBaseViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/4.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYBaseViewController: UIViewController,DYNavigationBarDelegate{
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
        dyNavBar.delegate = self
        view.backgroundColor = UIColor.orange
        
        
    }
}

extension DYBaseViewController{
    func navigationBarItemDidSelect(bar: DYNavigationBar, item: UIImageView, type: DYNavigationBarItemType) {
        if type == .login {
            let login = DYLoginViewController()
            self.navigationController?.pushViewController(login, animated: true)
        }else if type == .history{
            
        }
    }
}

extension DYBaseViewController{
    private func setupUI(){
        //        view.addSubview(collectionView)
    }
}
