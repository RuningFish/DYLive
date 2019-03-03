//
//  DYRecommendNormalCell.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit
import Kingfisher
class DYRecommendNormalCell: UICollectionViewCell {
    
    @IBOutlet weak var coverImageView: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var views: UILabel!
    @IBOutlet weak var content: UILabel!
    @IBOutlet weak var type: UILabel!
    
    var normalModel : DYRecommendNormal? {
        didSet{
            if let iconURL = URL(string: normalModel?.vertical_src ?? "") {
                coverImageView.kf.setImage(with: iconURL)
            } else {
                coverImageView.image = UIImage(named: "home_column_more")//home_more_btn
            }
            name.text = normalModel?.nickname
            var count = Double(CGFloat((normalModel?.online)!)/1000).rounded()
            count = count/Double(10)
            views.text = "\(count)万"
            content.text = normalModel?.room_name
            let text = "\(normalModel!.game_name)\(" >")"
            type.text = text
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
//        // Initialization code
//        name.textColor = UIColor.white
//        views.textColor = UIColor.white
//        con
    }
}
