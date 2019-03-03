//
//  DYRecommendHeaderView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYRecommendHeaderView: UICollectionReusableView {

    @IBOutlet weak var hotLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        hotLabel.font = UIFont.init(name: "Helvetica-Bold", size: 18)
    }
    
}
