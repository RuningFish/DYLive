//
//  DYImageTitleView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/12.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
private let KLabelHeight :CGFloat = 20
private let KImageHeight :CGFloat = 30
enum DYImageTitleViewType :Int{
    case top = 0
    case left = 1
    case bottom = 2
    case right = 3
}

protocol DYImageTitleViewDelegate {
    func didClick(view:DYImageTitleView)
}

class DYImageTitleView: UIView {

    var imageView:UIImageView?
    var titleLabel:UILabel?
    var delegate:DYImageTitleViewDelegate?
    
    init(frame: CGRect,type:DYImageTitleViewType,space:CGFloat = 0) {
        super.init(frame: frame)
        addSubview(image)
        addSubview(label)
        self.imageView = image
        self.titleLabel = label
//        label.sizeToFit()
        
        image.snp.removeConstraints()
        label.snp.removeConstraints()
        switch type {
        case .top:
            label.snp.makeConstraints({ (make) in
                make.left.top.right.equalToSuperview().offset(0)
                make.height.equalTo(KLabelHeight)
            })
            image.snp.makeConstraints({ (make) in
                make.top.equalTo(label.snp.bottom).offset(space)
                make.bottom.equalTo(0)
                make.centerX.equalToSuperview().offset(0)
                make.width.equalTo(frame.size.height-KLabelHeight)
            })
            
        case .left:
            image.snp.makeConstraints({ (make) in
                make.right.centerY.equalToSuperview().offset(0)
                make.width.height.equalTo(KImageHeight)
            })
            label.snp.makeConstraints({ (make) in
                make.left.equalToSuperview().offset(0)
                make.height.equalTo(KLabelHeight)
                make.right.equalTo(image.snp.left).offset(-space)
                make.centerY.equalToSuperview().offset(0)
            })
            
        case .bottom:
            label.snp.makeConstraints({ (make) in
                make.bottom.left.right.equalToSuperview().offset(0)
                make.height.equalTo(KLabelHeight)
            })
            image.snp.makeConstraints({ (make) in
                make.bottom.equalTo(label.snp.top).offset(-space)
                make.top.equalToSuperview().offset(0)
                make.centerX.equalToSuperview().offset(0)
                make.width.equalTo(frame.size.height-KLabelHeight)
            })
            
        case .right:
            
            image.snp.makeConstraints({ (make) in
                make.left.centerY.equalToSuperview().offset(0)
                make.width.height.equalTo(KImageHeight)
            })
            
            label.snp.makeConstraints({ (make) in
                make.left.equalTo(image.snp.right).offset(space)
                make.right.equalToSuperview().offset(0)
                make.height.equalTo(KLabelHeight)
                make.centerY.equalToSuperview().offset(0)
            })
        }
        
        isUserInteractionEnabled = true
        let tapGesture = UITapGestureRecognizer(target:self,action:#selector(tap))
        addGestureRecognizer(tapGesture)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    @objc func tap(){
        self.delegate?.didClick(view: self)
    }
    
    
    private lazy var image :UIImageView = {
        let view = UIImageView()
        return view
    }()
    
    private lazy var label :UILabel = {
        let view = UILabel()
        return view
    }()
}
