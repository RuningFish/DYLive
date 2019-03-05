//
//  DYRecommendBeautyCell.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/4.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYRecommendBeautyCell: UICollectionViewCell {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var nickNmae: UILabel!
    @IBOutlet weak var online: UILabel!
    @IBOutlet weak var location: UILabel!
    
    var beauty:DYRecommendBeautyModel? {
        didSet{
            if let iconURL = URL(string: beauty?.vertical_src ?? "") {
                imageView.kf.setImage(with: iconURL)
            } else {
                imageView.image = UIImage(named: "home_column_more")//home_more_btn
            }
            nickNmae.text = beauty?.nickname
            var count = Double(CGFloat((beauty?.online)!)/1000).rounded()
            count = count/Double(10)
            online.text = "\(count)万"
            location.text = beauty?.anchor_city
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
//    override init(frame: CGRect) {
//        super.init(frame:frame)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
////        fatalError("init(coder:) has not been implemented")
//    }
}
