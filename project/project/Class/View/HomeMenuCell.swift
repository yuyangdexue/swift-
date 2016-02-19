//
//  HomeMenuCell.swift
//  project
//
//  Created by 于洋 on 16/1/8.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit


let   kCornerSquare:CGFloat = 16 * kDeviceFactor

class HomeMenuCell: UICollectionViewCell {
    
    var imgMark:UIImageView?
    var imageMarkDisableLable : UILabel?
    var lblTitle:UILabel?
    var messageNum: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override  init(frame: CGRect) {
        super.init(frame: frame)
        pSetup()
        
    }
    
    func resetWithModel(model:TabarSubModel){
        
        if (model.disabled.value == 1){
            imgMark?.image = UIImage(named:model.image_hl.value!)
            lblTitle?.textColor = UIColor.colorWithHexString("bebebe")
            imageMarkDisableLable?.hidden = false
        } else{
            imgMark?.image = UIImage(named: model.image.value!)
            lblTitle?.textColor = kColor_Black_Color
            imageMarkDisableLable?.hidden = true
        }
        
        lblTitle?.text = model.title.value
        imgMark?.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - 17)
        
        
    }


    
   
    
}

extension HomeMenuCell{
   private  func pSetup(){
        
        let selView:UIView = UIView(frame: frame)
        selView.backgroundColor = kColor_MainBg_Color
        self.selectedBackgroundView =  selView
        self.backgroundColor = UIColor.whiteColor()
        
        let bgSize : CGSize =  self.frame.size
        
        let lineR : UIView = UIView(frame: CGRectMake(bgSize.width - 0.5, 0, 0.5, bgSize.height))
        lineR.backgroundColor = kColor_Line_Color
        self .addSubview(lineR)
        
        let lineB : UIView = UIView(frame: CGRectMake(0, bgSize.height - 0.5, bgSize.width, 0.5))
        lineB.backgroundColor = kColor_Line_Color
        self .addSubview(lineB)
        
        imgMark = UIImageView(frame: CGRectMake(0, 0, 30, 30))
        imgMark?.center=CGPointMake(self.frame.size.width/2, self.frame.size.height/2-17)
        imgMark?.contentMode = UIViewContentMode.ScaleAspectFill
        imgMark?.clipsToBounds = true
        self .addSubview(imgMark!)
        
        imageMarkDisableLable = UILabel.customizedUILable(CGRectMake(bgSize.width - 40 - 5, 0, 40, 14), text: "即将开通", textColor: UIColor.colorWithHexString("bebebe"), fontSize: 9, textAlignment: NSTextAlignment.Center)
        self .addSubview(imageMarkDisableLable!)
        imageMarkDisableLable?.hidden = true
        
        UIView.bezierPathWithRoundedView(imageMarkDisableLable!, upLeft: UIRectCorner.TopLeft, upRight:  UIRectCorner.TopRight, bottomLeft: UIRectCorner.BottomLeft, bottomRight: UIRectCorner.BottomRight, cornerlayerSize: 2)
        
        lblTitle = UILabel.customizedUILable(CGRectMake(0, 0, self.frame.size.width, 28), text: "", textColor: kColor_Black_Color, fontSize: 15, textAlignment: NSTextAlignment.Center)
        lblTitle?.center = CGPointMake(bgSize.width / 2, bgSize.height / 2 + 20)
        self .addSubview(lblTitle!)
        
        messageNum = UILabel.customizedUILable(CGRectMake(self.frame.size.width / 2 + 15,
            self.frame.size.height / 2 - 17 - 17 - 15,
            kCornerSquare, kCornerSquare), text: "1", textColor: UIColor.whiteColor(), fontSize: 14, textAlignment: NSTextAlignment.Center)
        messageNum?.backgroundColor = UIColor.redColor()
        messageNum?.layer.masksToBounds = true
        messageNum?.layer.cornerRadius = kCornerSquare/2
        
        self .addSubview(messageNum!)
        messageNum?.hidden = true
        
    }

}
