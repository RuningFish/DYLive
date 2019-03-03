//
//  DYTabBarViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYTabBarViewController: UITabBarController {

    private var controllers = [UIViewController]()
    override func viewDidLoad() {
        super.viewDidLoad()
        let myTabBar = DYTabBar(frame:self.tabBar.frame)
        myTabBar.myDelegate = self
        self.setValue(myTabBar, forKey: "tabBar")
        let originalTabBar = UITabBar.appearance()
//        originalTabBar.shadowImage = UIImage()
        originalTabBar.backgroundImage = UIImage.imageWithColor(color: UIColor.white)
        addChildControllers()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        for view in self.tabBar.subviews{
            if view.isKind(of: DYTabBarItem.self){
            }else{
                view.removeFromSuperview()
            }
        }
    }
    // 添加子控制器
    func addChildControllers() {
        print("DYTabBarViewController")
        let recommend = DYRecommendViewController()
        let entertainment = DYEntertainmentViewController()
        let follows = DYFollowsViewController()
        let bar = DYBarViewController()
        let discover = DYDiscoverViewController()
        entertainment.view.backgroundColor = UIColor.green
        follows.view.backgroundColor = UIColor.yellow
        bar.view.backgroundColor = UIColor.blue
        discover.view.backgroundColor = UIColor.purple
        controllers = [recommend,entertainment,follows,bar,discover]
        self.viewControllers = [recommend,entertainment,follows,bar,discover]
//        return
        
        // Do any additional setup after loading the view.
//        let recommend = getController(name: "DYRecommendViewController", title: "推荐", oriImage: "tabLive", selImage: "tabLiveHL")
//        recommend.view.backgroundColor = UIColor.red
//        let entertainment = getController(name: "DYEntertainmentViewController", title: "娱乐", oriImage: "tabYule", selImage: "tabYuleHL")
//        entertainment.view.backgroundColor = UIColor.green
//        let follows = getController(name: "DYFollowsViewController", title: "关注", oriImage: "tabFocus", selImage: "tabFocusHL")
//        follows.view.backgroundColor = UIColor.yellow
//        let bar = getController(name: "DYBarViewController", title: "鱼吧", oriImage: "tabYuba", selImage: "tabYubaHL")
//        bar.view.backgroundColor = UIColor.blue
//        let discover = getController(name: "DYDiscoverViewController", title: "发现", oriImage: "tabDiscovery", selImage: "tabDiscoveryHL")
//        discover.view.backgroundColor = UIColor.purple
//        self.viewControllers = [recommend,entertainment,follows,bar,discover]
    }
    
    func getController(name:String ,title:String, oriImage:String, selImage:String) -> UIViewController{
        var viewController :UIViewController? = nil
        guard let clsName = Bundle.main.infoDictionary!["CFBundleExecutable"] else {
            print("命名空间不存在")
            return viewController!
        }
        // 2.通过命名空间和类名转换成类
        let cls : AnyClass? = NSClassFromString((clsName as! String) + "." + name)
        
        guard let clsType = cls as? UIViewController.Type else {
            print("类不存在")
            return UIViewController()
        }
        
        viewController = clsType.init()
//        viewController!.title = title
//
//        // 去除图片的渲染
//        viewController!.tabBarItem.image = UIImage.imageWithOriginal(oriImage)
//        viewController!.tabBarItem.selectedImage = UIImage.imageWithOriginal(selImage)
//        // 去除文字的渲染
//        self.tabBar.tintColor = UIColor.orange
//        self.tabBar.unselectedItemTintColor = UIColor.gray
        return viewController!
    }
    
    func originalImage() {
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension DYTabBarViewController:DYTabBarDelegate{
    func tabBarDidSelect(tabBar: DYTabBar, fromIndex: Int, toIndex: Int) {
//        print("fromIndex \(fromIndex) toindex :\(toIndex) \(self.viewControllers)")
        self.selectedIndex = toIndex
//        self.selectedViewController = controllers[toIndex]
    }
}
