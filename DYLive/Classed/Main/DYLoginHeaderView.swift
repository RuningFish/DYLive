//
//  DYLoginHeaderView.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/5.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYLoginHeaderView: UIView {
    
    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var loginBtn: UIButton!
    @IBOutlet weak var registerBtn: UIButton!
    
    override init(frame: CGRect) {
        super.init(frame:frame)
        addSubview(loadView())
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func loadView() -> UIView{
        let nib = UINib(nibName:"DYLoginHeaderView", bundle:nil)
        let view = nib.instantiate(withOwner: self, options: nil).first as! UIView
        view.frame = self.bounds
        return view
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        title.font = UIFont(name:Helvetica_Bold, size:20)
        loginBtn.layer.borderWidth = 2
        loginBtn.layer.borderColor = UIColor.orange.cgColor
        registerBtn.layer.borderWidth = 2
        registerBtn.layer.borderColor = UIColor.orange.cgColor
        
        loginBtn.setTitleColor(UIColor.orange, for: .normal)
        
        registerBtn.setTitleColor(UIColor.orange, for: .normal)
        registerBtn.setTitleColor(UIColor.white, for: .highlighted)
        loginBtn.tag = 1
        registerBtn.tag = 2
        
        loginBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        registerBtn.addTarget(self, action: #selector(btnClick), for: .touchUpInside)
        btnClick(btn: loginBtn)
    }
}

extension DYLoginHeaderView {
    @objc func btnClick(btn:UIButton){
        if btn.tag == 1 {
            loginBtn.backgroundColor = UIColor.orange
            loginBtn.setTitleColor(UIColor.white, for: .normal)
            registerBtn.backgroundColor = UIColor.white
            registerBtn.setTitleColor(UIColor.orange, for: .normal)
        }else if btn.tag == 2{
            registerBtn.backgroundColor = UIColor.orange
            registerBtn.setTitleColor(UIColor.white, for: .normal)
            loginBtn.backgroundColor = UIColor.white
            loginBtn.setTitleColor(UIColor.orange, for: .normal)
        }
        
    }
}
