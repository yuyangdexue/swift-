//
//  HomeMenuHeader.swift
//  project
//
//  Created by 于洋 on 16/1/8.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit

class HomeMenuHeader: UICollectionReusableView {
    
    var circleView :CirCleView?
    override  init(frame: CGRect) {
        super.init(frame: frame)
        
        pSetup()
    }
    
    func pSetup(){
//        let img : UIImageView = UIImageView(frame: CGRectMake(0, 0, kDeviceWidth, HeaderHeight * kDeviceFactor))
//        img.image = UIImage(named: "1")
//    
//      self .addSubview(img)
        
  
        let imageArray: [UIImage!] = [UIImage(named: "1"), UIImage(named: "2"), UIImage(named: "3"),UIImage(named: "4")]
        
        self.circleView = CirCleView(frame: CGRectMake(0, 0, self.frame.size.width, self.frame.size.height), imageArray: imageArray)
        circleView!.backgroundColor = UIColor.orangeColor()
        self.addSubview(circleView!)
        

    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
