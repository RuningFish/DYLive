//
//  DYLoginTableViewCell.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/5.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYLoginTableViewCell: UITableViewCell {

    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var descText: UILabel!
    
    var dict :[String:Any?]? {
        didSet{
            guard let dic = dict else {return}
            name.text = dic["name"] as? String
            descText.text = dic["text"] as? String
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
