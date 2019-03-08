//
//  DYYuBaTableViewCell.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/5.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYYuBaTableViewCell: UITableViewCell {

//    @IBOutlet weak var topView: DYYuBaTopView!
    var model : DYYuBaModel? {
        didSet{
            topView.model = model
            content.model = model
            bottomTooView.model = model
            let commentsCount = model!.sub_comments!.count as!Int
            
            if model?.created_at == "昨天17:30" {
                print("commentsCount -------- \(commentsCount)")
            }
            if commentsCount > 0 {
                contentView.addSubview(subCommentsView)
                subCommentsView.model = model
                bottomTooView.snp.removeConstraints()
                subCommentsView.snp.makeConstraints { (make) in
                    make.top.equalTo(content.snp.bottom).offset(0)
                    make.left.equalToSuperview().offset(KContentLeftMargin)
                    make.right.equalToSuperview().offset(-KContentLeftMargin)
                    make.height.equalTo(50)
                }
                
                bottomTooView.snp.makeConstraints({ (make) in
                    make.left.right.equalToSuperview().offset(0)
                    make.top.equalTo(subCommentsView.snp.bottom).offset(5)
                    make.height.equalTo(50)
                    make.bottom.equalTo(0)
                })
            }else{
                subCommentsView.snp.removeConstraints()
                subCommentsView.removeFromSuperview()
                bottomTooView.snp.removeConstraints()
                bottomTooView.snp.makeConstraints({ (make) in
                    make.left.right.equalToSuperview().offset(0)
                    make.top.equalTo(content.snp.bottom).offset(5)
                    make.height.equalTo(50)
                    make.bottom.equalTo(0)
                })
            }
            
        }
    }
    private let topView:DYYuBaTopView = DYYuBaTopView()
    private let content:DYYubaContentView = DYYubaContentView()
    private let subCommentsView:DYYuBaCommnetsView = DYYuBaCommnetsView()
    private let bottomTooView:DYBottomToolView = DYBottomToolView()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        print("style: UITableViewCellStyle")
        selectionStyle = .none
        contentView.addSubview(topView)
        contentView.addSubview(content)
//        contentView.addSubview(subCommentsView)
        contentView.addSubview(bottomTooView)
        
        topView.snp.makeConstraints { (make) in
            make.left.right.top.equalToSuperview().offset(0)
        }
        
        content.snp.makeConstraints { (make) in
            make.top.equalTo(topView.snp.bottom).offset(0)
            make.left.right.equalToSuperview().offset(0)
//            make.bottom.equalTo(-5)
        }
        
//        subCommentsView.snp.makeConstraints { (make) in
//            make.top.equalTo(content.snp.bottom).offset(0)
//            make.left.equalToSuperview().offset(KContentLeftMargin)
//            make.right.equalToSuperview().offset(-KContentLeftMargin)
//            make.height.equalTo(50)
//            make.bottom.equalTo(-5)
//        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
//        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
    }
}
