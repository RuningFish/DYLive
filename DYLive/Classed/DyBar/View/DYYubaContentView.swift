//
//  DYYubaContentView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/6.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
private let margin :CGFloat = 5
private let column :Int = 3
private let verticalW :CGFloat = 150.0
private let verticalH :CGFloat = 200.0
private let horizontalW :CGFloat = 250.0
private let horizontalH :CGFloat = horizontalW/16.0*9.0
class DYYubaContentView: UIView {

    var model : DYYuBaModel? {
        didSet{
            title.text = model?.title
            let count = model?.content?.characters.count as! Int
            if count >= 50 {
                content.text = "\(model!.content!.prefix(50))\("...")"
            }else{
                content.text = model!.content!
            }
            
            setImageContainer()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        imageContainerView.backgroundColor = UIColor.white
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // lazy
    lazy var title :UILabel = { () in
        let label = UILabel()
        label.numberOfLines = 0
        return label
    }()
    
    lazy var content :UILabel = { () in
        let label = UILabel()
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 14)
        return label
    }()
    
    lazy var imageContainerView = { () -> UIView in
        let view = UIView()
        view.backgroundColor = UIColor.orange
        return view
    }()
}

extension DYYubaContentView {
    func setupUI(){
        addSubview(title)
        addSubview(content)
        addSubview(imageContainerView)

        title.sizeToFit()
        content.sizeToFit()
        
        title.snp.makeConstraints { (make) in
            make.top.equalToSuperview().offset(0)
            make.left.equalToSuperview().offset(KContentLeftMargin)
            make.right.equalToSuperview().offset(-KContentLeftMargin)
        }
        
        content.snp.makeConstraints { (make) in
            make.top.equalTo(title.snp.bottom).offset(5)
            make.left.right.equalTo(title).offset(0)
        }
    }
    
    func setImageContainer(){
        let imgCount = model!.imglist!.count as!Int
        imageContainerView.snp.removeConstraints()
        for v in imageContainerView.subviews{
            v.removeFromSuperview()
        }
        
        if imgCount > 0{
            content.snp.removeConstraints()
            content.snp.makeConstraints({ (make) in
                make.top.equalTo(title.snp.bottom).offset(5)
                make.left.right.equalTo(title).offset(0)
            })
            var imageContainerViewW :CGFloat = 0
            var imageContainerViewH :CGFloat = 0
            
            if imgCount == 1{
                let img = UIImageView()
                imageContainerView.addSubview(img)
                let list = model?.imglist![0] as! DYYuBaImglist
                let size = list.size as! [String:Any]
                let w = size["w"] as! CGFloat
                let h = size["h"] as! CGFloat
                if w <= h{
                    img.frame = CGRect.make(0, 0, verticalW, verticalH)
                    imageContainerViewW = verticalW + margin
                    imageContainerViewH = verticalH + margin
                }else{
                    img.frame = CGRect.make(0, 0, horizontalW, horizontalH)
                    imageContainerViewW = horizontalW + margin
                    imageContainerViewH = horizontalH + margin
                }
                img.backgroundColor = UIColor.lightGray
                img.kf.setImage(with: URL(string: list.url ?? ""))
            }else{
                let size = imgCount > column ? column : imgCount
                let width = (KScreenWidth - KContentLeftMargin*2 - CGFloat(size-1)*margin)/CGFloat(size)
                let height = width
                imageContainerViewW = KScreenWidth - KContentLeftMargin*2
                for (index,value) in model!.imglist!.enumerated(){
                    let img = UIImageView()
                    imageContainerView.addSubview(img)
                    let x = (width + margin)*CGFloat(index%column)
                    let y = (width + margin)*CGFloat(index/column)
                    img.frame = CGRect.make(x, y, width, height)
                    img.backgroundColor = UIColor.lightGray
                    img.kf.setImage(with: URL(string: value.url ?? ""))
                    
                    if index == imgCount-1 {
                        imageContainerViewH = img.frame.maxY + margin
                    }
                }
            }
            
            imageContainerView.snp.makeConstraints { (make) in
                make.top.equalTo(content.snp.bottom).offset(5)
                make.left.equalTo(content.snp.left).offset(0)
                make.height.equalTo(imageContainerViewH)
                make.width.equalTo(imageContainerViewW)
                make.bottom.equalTo(-5)
            }
        }else{
            content.snp.removeConstraints()
            content.snp.makeConstraints { (make) in
                make.top.equalTo(title.snp.bottom).offset(5)
                make.left.right.equalTo(title).offset(0)
                make.bottom.equalTo(-5)
            }
        }
    }
}

