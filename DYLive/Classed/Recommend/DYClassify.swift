//
//  DYClassify.swift
//  DYLive
//
//  Created by xiaoshayu on 2019/3/2.
//  Copyright © 2019年 xiaoshayu. All rights reserved.
//

import UIKit

class DYClassify: UIViewController {

    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor.white
        let imageView = UIImageView()
        imageView.frame = CGRect.make(100, 100, 30, 30)
        view.addSubview(imageView)
        imageView.backgroundColor = UIColor.red
        
        let p = "\(Bundle.DYResourceBundle)\("/becomeNobie@2x.png")"
        
        
//        let xxx = "\(Bundle.main.resourcePath ?? "\(Bundle.DYResourceBundle)")"
//        
//        
//        let image = UIImage(named: "becomeNobie@2x.png", in: Bundle(path: xxx), compatibleWith: nil)
//        imageView.image = image
//        print(image)
//        return
        let pat = "\(Bundle.main.resourcePath ?? "DYResource.bundle")"
        
        guard let path = Bundle.main.path(forResource: "gif_tabFocus.gif", ofType: nil),
            let data = NSData(contentsOfFile: path),
            let imageSource = CGImageSourceCreateWithData(data, nil) else { return }
        
        var images = [UIImage]()
        var totalDuration : TimeInterval = 0.5
        for i in 0..<CGImageSourceGetCount(imageSource) {
            guard let cgImage = CGImageSourceCreateImageAtIndex(imageSource, i, nil) else { continue }
            let image = UIImage(cgImage: cgImage)
            i == 0 ? imageView.image = image : ()
            images.append(image)
            
            guard let properties = CGImageSourceCopyPropertiesAtIndex(imageSource, i, nil) as? NSDictionary,
                let gifDict = properties[kCGImagePropertyGIFDictionary] as? NSDictionary,
                let frameDuration = gifDict[kCGImagePropertyGIFDelayTime] as? NSNumber else { continue }
            totalDuration += frameDuration.doubleValue
        }
        
        imageView.animationImages = images
        imageView.animationDuration = totalDuration
        imageView.animationRepeatCount = 1
        
        imageView.startAnimating()
    }
    
    
}

