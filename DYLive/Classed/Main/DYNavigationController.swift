//
//  DYNavigationController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYNavigationController: UINavigationController {

    lazy var dyNavBar = { () -> DYNavigationBar in
        let navBar = DYNavigationBar()
        navBar.frame = CGRect(x:0,y:0,width:KScreenWidth,height:KNavigationHeight)
        navBar.backgroundColor = UIColor.orange
        return navBar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.isHidden = true
//        view.addSubview(dyNavBar)
        // Do any additional setup after loading the view.
        
//        NotificationCenter.xsyAddobserver(self, selector: #selector(setNavigationBar), postName: KRecommendContentScrollNotification, object: nil)
    }

    @objc func setNavigationBar(noti:Notification){
//        guard let direction = noti.object as? RecommendScrollDirection else {return}
//        print(direction)
//        if direction == .up {
//            UIView.animate(withDuration: 0.2, animations: {
//                self.dyNavBar.frame = CGRect.make(0, 0, KScreenHeight, 0)
//            })
//        }else if direction == .down {
//            view.addSubview(dyNavBar)
//            UIView.animate(withDuration: 0.2, animations: {
//                self.dyNavBar.frame = CGRect(x:0,y:0,width:KScreenWidth,height:KNavigationHeight)
//            })
//        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    class Singleton {
        static let instance = Singleton()
        private init(){}
    }
}
