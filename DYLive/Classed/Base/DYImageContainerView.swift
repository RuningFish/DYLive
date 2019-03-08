//
//  DYImageContainerView.swift
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

private  class DYImageBaseView :UIView {
    var reuseIdentifier : String?
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

private class DYImageVerticalView: DYImageBaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.make(0, 0, verticalW + margin, verticalH + margin)
        addSubview(imageView)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // #lazy
    lazy var imageView :UIImageView = { () in
        let imageView = UIImageView()
        imageView.frame = CGRect.make(0, 0, verticalW, verticalH)
        return imageView
    }()
}

private class DYImageHorizontalView: DYImageBaseView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.frame = CGRect.make(0, 0, horizontalW + margin, horizontalW + margin)
        addSubview(imageView)
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    // #lazy
    lazy var imageView :UIImageView = { () in
        let imageView = UIImageView()
        imageView.frame = CGRect.make(0, 0, horizontalW, horizontalH)
        return imageView
    }()
}

enum DYImageContainerViewType :String{
    case imageVertical = "Vertical"
    case imageHorizontal = "Horizontal"
    case imageDouble = "Double"
    case imageMore = "More"
}

class DYImageContainerView: UIView {

    private static var containerSets:[DYImageBaseView] = [DYImageBaseView]()
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    init(width: CGFloat,type: DYImageContainerViewType, imgList: [URL])  {
        super.init(frame:CGRect.zero)
        var cacheView :UIView?
        let imgNum = imgList.count
        if type == .imageVertical && imgNum == 1 {
            cacheView = typeForView(type:type)
            guard let _ = cacheView else {
                let verticalView = DYImageVerticalView()
                addSubview(verticalView)
                verticalView.reuseIdentifier = type.rawValue
                verticalView.imageView.kf.setImage(with: imgList[0])
                DYImageContainerView.containerSets.append(verticalView)
                print("新创建的竖屏图片 \(String(format:"%p",DYImageContainerView.containerSets))")
                return
            }
            addSubview(cacheView!)
            cacheView = (cacheView as! DYImageVerticalView)
            guard let verticalView = cacheView as? DYImageVerticalView else {return}
            print("缓存的竖屏图片 \(cacheView)")
            verticalView.imageView.kf.setImage(with: imgList[0])
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func typeForView(type:DYImageContainerViewType) -> UIView? {
        var view :UIView?
        print("------------------------------ \(DYImageContainerView.containerSets)")
        for (index,cache) in DYImageContainerView.containerSets.enumerated() {
            print("reuseIdentifier : \(cache.reuseIdentifier!)  type.rawValue : \(type.rawValue)")
            if cache.reuseIdentifier == type.rawValue{
                view = cache
                DYImageContainerView.containerSets.remove(at: index)
                break
            }
        }
        return view
    }
}

//extension UIView{
//    var reuseIdentifier :String?{
//        set{
//            objc_setAssociatedObject(self, "reuseIdentifier", newValue, .OBJC_ASSOCIATION_COPY_NONATOMIC)
//        }
//        get{
//            let string = objc_getAssociatedObject(self, "reuseIdentifier") as? String
//            return string
//        }
//    }
//}

