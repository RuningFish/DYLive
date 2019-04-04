//
//  DYWebViewController.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/4/3.
//  Copyright © 2019 xiaoshayu. All rights reserved.
//

import UIKit

class DYWebViewController: UIViewController,UIWebViewDelegate {

    var url:String = ""{
        didSet{
            if url.hasPrefix("http") || url.hasPrefix("https"){
                loadRequest()
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        self.navigationController?.navigationBar.isHidden = true
        setupUI()
    }
    
    lazy var webView:UIWebView = {() in
        let view = UIWebView()
        view.backgroundColor = .clear
        view.frame = CGRect.make(0, KStatusBarHeight + 44, KScreenWidth, KScreenHeight-KNavigationHeight)
        view.delegate = self
        return view
    }()
    
    lazy var backView:UIView = { () in
        let view = UIView()
        view.frame = CGRect.make(0, KStatusBarHeight, KScreenWidth, 44)
        return view
    }()
    
    lazy var backBtn:UIButton = {() in
        let view = UIButton.init(type: .custom)
        view.setImage(UIImage(named: "btn_back_portrait_total_rank"), for: .normal)
        view.addTarget(self, action: #selector(back), for:.touchUpInside)
        return view
    }()
    
    lazy var titleL:UILabel = {() in
        let view = UILabel()
        view.font = UIFont(name: Helvetica_Bold, size: 17)
        view.textAlignment = .center
        return view
    }()
    

    @objc func back(){
        self.navigationController?.popViewController(animated: true)
    }
    
    func loadRequest() {
        guard let requestURL = URL(string: url) else { return }
        let request = URLRequest(url: requestURL, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 60)
        webView.loadRequest(request)
    }
    
    func setupUI() {
        view.addSubview(backView)
        backView.addSubview(backBtn)
        backView.addSubview(titleL)
        backView.backgroundColor = .clear
        titleL.backgroundColor = .clear
        
        backBtn.snp.makeConstraints { (make) in
            make.left.equalToSuperview().offset(10)
            make.centerY.equalTo(backView.snp.centerY).offset(0)
            make.width.height.equalTo(44)
        }
        
        titleL.snp.makeConstraints { (make) in
            make.left.equalTo(backBtn.snp.right).offset(20)
            make.right.equalToSuperview().offset(-60)
            make.top.bottom.equalToSuperview().offset(0)
        }
        
//        webView.snp.makeConstraints { (make) in
//            make.left.right.equalToSuperview().offset(0)
//            make.top.equalTo(backView.snp.bottom).offset(0)
//            make.bottom.equalToSuperview().offset(0)
//        }
    }
}

extension DYWebViewController{
    func webViewDidStartLoad(_ webView: UIWebView) {
        print("webViewDidStartLoad")
    }
    
    func webViewDidFinishLoad(_ webView: UIWebView) {
        view.addSubview(webView)
        print("webViewDidFinishLoad")
        let title = webView.stringByEvaluatingJavaScript(from: "document.title")
        titleL.text = title ?? ""
    }
    
    func webView(_ webView: UIWebView, didFailLoadWithError error: Error) {
        print("didFailLoadWithError")
    }

}
