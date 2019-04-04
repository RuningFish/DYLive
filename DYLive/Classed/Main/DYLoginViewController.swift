//
//  DYLoginViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/5.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

private let KLoginCellIdentifier = "DYLoginViewCell"
private let KLoginHeaderHeight :CGFloat = 170.0
class DYLoginViewController: UIViewController,UITableViewDataSource,UITableViewDelegate {

    @IBOutlet weak var back: UIButton!
    @IBOutlet weak var setting: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    var loginData :[[[String:Any?]]] = [[[String:Any?]]]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.white
        back.addTarget(self, action: #selector(pop), for: .touchUpInside)
        setting.addTarget(self, action: #selector(set), for: .touchUpInside)
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(UINib(nibName: "DYLoginTableViewCell", bundle: nil), forCellReuseIdentifier: KLoginCellIdentifier)
        let headerView = DYLoginHeaderView(frame:CGRect.make(0, 0, KScreenWidth, KLoginHeaderHeight))
        tableView.tableHeaderView = headerView
       
        loginData = [[["name":"我的等级","text":"未登录"],
                      ["name":"我的空间","text":""],
                      ["name":"我的粉丝徽章","text":"未登录"],
                      ["name":"小姐姐特权","text":"斗鱼小姐姐的专属特权"],
                      ["name":"我的积分","text":"未登录"]],
                    
                    [["name":"游戏中心","text":"玩游戏领鱼丸"],
                      ["name":"我的竞猜","text":""],
                      ["name":"金牌陪玩","text":""]],
                    
                    [["name":"主播招聘","text":""],
                     ["name":"排行榜","text":""]],
                    
                    [["name":"我的视频","text":""],
                     ["name":"视频收益","text":""],
                     ["name":"视频收藏","text":""]],
                    
                    [["name":"我的账户","text":""],
                     ["name":"免流量特权","text":""]],
                    
                    [["name":"关注管理","text":""],
                     ["name":"开播提醒","text":""]],
                    ]
    }

    @objc  func pop() {
        self.navigationController?.popViewController(animated: true)
    }
    
    @objc  func set() {
        print("setting ---")
    }
    
}

extension DYLoginViewController {
    func numberOfSections(in tableView: UITableView) -> Int {
        return self.loginData.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.loginData[section].count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: KLoginCellIdentifier, for: indexPath) as! DYLoginTableViewCell
        let section = self.loginData[indexPath.section]
        cell.dict = section[indexPath.item]
        return cell
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = UIView()
        header.frame = CGRect.make(0, 0, KScreenWidth, 5)
        header.backgroundColor = UIColor.colorWithRGB(r: 247, g: 247, b: 247)
        return header
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 5
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let itemString = self.loginData[indexPath.section][indexPath.row]["name"] as! String
        if itemString == "我的账户" {
//            print("=====")
//            self.navigationController?.pushViewController(TestViewController(), animated: true)
        }
    }
}


extension DYLoginViewController {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let sectionHeight :CGFloat = 5
        if scrollView.contentOffset.y <= sectionHeight && scrollView.contentOffset.y >= 0 {
            scrollView.contentInset = UIEdgeInsetsMake(-scrollView.contentOffset.y, 0, 0, 0)
        }else if scrollView.contentOffset.y >= sectionHeight{
            scrollView.contentInset = UIEdgeInsetsMake(-sectionHeight, 0, 0, 0)
        }
    }
}
