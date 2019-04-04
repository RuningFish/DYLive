//
//  DyBarViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/2/28.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
private let KYuBaCellIdentifier = "KYuBaCellIdentifier"
class DYBarViewController: DYBaseViewController,UITableViewDataSource,UITableViewDelegate{

    private var prototypeCell:DYYuBaTableViewCell?
    private var data :[DYYuBaModel] = [DYYuBaModel]()
    override func viewDidLoad() {
        super.viewDidLoad()
        print("DYBarViewController")
        view.addSubview(tableView)
        loadData()
    }
    
    // lazy
    lazy var tableView :UITableView = { [unowned self] in
        let tableView = UITableView(frame: CGRect.make(0, KNavigationHeight, KScreenWidth, KScreenHeight - KNavigationHeight - KTabBarHeight), style: .plain)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.separatorStyle = .none
        tableView.estimatedRowHeight = 200
        tableView.rowHeight = UITableViewAutomaticDimension
        tableView.register(DYYuBaTableViewCell.self, forCellReuseIdentifier: KYuBaCellIdentifier)
        self.prototypeCell = tableView.dequeueReusableCell(withIdentifier: KYuBaCellIdentifier) as? DYYuBaTableViewCell
        return tableView
    }()
    
    func loadData(){
        let path :String? = Bundle.main.path(forResource: "data", ofType: ".plist")
        let dict = NSDictionary(contentsOfFile:path ?? "") as? [String:Any?]
        let data = dict!["data"] as! [String:Any?]
        let list = data["list"] as! [[String:AnyObject]]
        
        for dic in list{
            let model = DYYuBaModel(dict:dic)
            self.data.append(model)
        }
        
    }
    
}

extension DYBarViewController{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = tableView.dequeueReusableCell(withIdentifier: KYuBaCellIdentifier) as! DYYuBaTableViewCell
        cell.model = self.data[indexPath.item]
//        cell.backgroundColor = UIColor.random_color()
        
        return cell
    }
    
//    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
////        return UITableViewAutomaticDimension
//        let cell = prototypeCell
//
//        let cellHeight :CGFloat = (cell?.contentView.systemLayoutSizeFitting(UILayoutFittingCompressedSize).height)! + 1.0
////        let model = data[indexPath.item]
//        print("cell的高度为 ======= \(cellHeight)")
//        return 500
//    }
    
//    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
//        return 100
//    }
    
}

extension DYBarViewController {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
    }
}
