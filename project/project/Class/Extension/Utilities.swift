//
//  Utilities.swift
//  project
//
//  Created by 于洋 on 16/1/7.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit

extension UITableView{
    
    func lineZero(){
        if ((self.respondsToSelector("setSeparatorInset:"))){
            self.separatorInset = UIEdgeInsetsZero
        }
        if((self.respondsToSelector("setLayoutMargins:"))){
            self.layoutMargins = UIEdgeInsetsZero
        }
        // self.contentInset=UIEdgeInsetsMake(-64, 0, 0, 0)
    }
    
}

extension UITextField{
    
    class  func  customizedUITextField(frame:CGRect, text:String ,palceholder :String ,textColor:UIColor, fontSize:CGFloat ,textAlignment:NSTextAlignment) -> UITextField{
        
        
        let  textField :UITextField = UITextField.init(frame: frame)
        textField.text = text
        textField.textColor = textColor
        textField.placeholder = palceholder
        textField.font = UIFont.systemFontOfSize(fontSize)
        textField.textAlignment = textAlignment
        textField.clearButtonMode = UITextFieldViewMode.WhileEditing
        return  textField
    }
    
}

extension UIImageView{
    class   func  customizedImageView(frame : CGRect ,imageName :String) -> UIImageView{
        let  imageView : UIImageView = UIImageView(frame: frame)
        imageView.image = UIImage.changeColorFromImage(kColor_Main_Color, imageName: imageName)
        return imageView
    }
}


extension  UIImage{
    class func  changeColorFromImage(finsihColor :UIColor, imageName:String)  ->UIImage{
        let image = UIImage(named: imageName)
        UIGraphicsBeginImageContextWithOptions((image?.size)!, false, 2)
        let content : CGContextRef = UIGraphicsGetCurrentContext()!
       CGContextTranslateCTM(content, 0, image!.size.height)
        CGContextScaleCTM(content, 1.0, -1.0)
        CGContextSetBlendMode(content, CGBlendMode.Normal)
        let rect: CGRect = CGRectMake(0, 0, (image?.size.width)!,  (image?.size.height)!)
        
        let loadImage = UIImage(named: imageName)
        let  cgImage :CGImageRef = (loadImage?.CGImage)!
        CGContextClipToMask(content, rect, cgImage)
        finsihColor.setFill()
        
        CGContextFillRect(content, rect)
        let newImage: UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
        
        
    }
    class  func   imageWithColor( color:UIColor) ->UIImage{
        
        let  rect:CGRect = CGRectMake(0, 0, 1, 1)
        UIGraphicsBeginImageContext(rect.size)
        let  content:CGContextRef = UIGraphicsGetCurrentContext()!
        CGContextSetFillColorWithColor(content, color.CGColor)
        CGContextFillRect(content, rect)
        let  image:UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
        
    }
    

    
}

extension UIColor{
   class   func colorWithHexString (hex:String) -> UIColor {
        var cString:String = hex.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet()).uppercaseString
        
        if (cString.hasPrefix("#")) {
            cString = (cString as NSString).substringFromIndex(1)
        }
        
//        if (cString.characters.count!= 6) {
//            return UIColor.grayColor()
//        }
        
        let rString = (cString as NSString).substringToIndex(2)
        let gString = ((cString as NSString).substringFromIndex(2) as NSString).substringToIndex(2)
        let bString = ((cString as NSString).substringFromIndex(4) as NSString).substringToIndex(2)
        
        var r:CUnsignedInt = 0, g:CUnsignedInt = 0, b:CUnsignedInt = 0;
        NSScanner(string: rString).scanHexInt(&r)
        NSScanner(string: gString).scanHexInt(&g)
        NSScanner(string: bString).scanHexInt(&b)
        
        
        return UIColor(red: CGFloat(r) / 255.0, green: CGFloat(g) / 255.0, blue: CGFloat(b) / 255.0, alpha: CGFloat(1))
    }
    
    
}

extension UIButton {
    
    class func  customizedButton(frame:CGRect, title:String , titleColorString:String ,  titleFont :CGFloat,radius:CGFloat ,backgroundImageColorString :
        String,  clickAction:Selector, viewController:AnyObject ) ->UIButton {
    
        let button = UIButton(type:.Custom)
        button.frame = frame
        button.setTitle(title, forState: UIControlState.Normal)
        button.setBackgroundImage(UIImage.imageWithColor(UIColor.colorWithHexString(backgroundImageColorString)), forState: UIControlState.Normal)
        button.setTitleColor(UIColor.colorWithHexString(titleColorString), forState: UIControlState.Normal)
        button.titleLabel?.font = UIFont.systemFontOfSize(titleFont)
        button .addTarget(viewController, action: clickAction, forControlEvents: .TouchUpInside)
        button.layer.masksToBounds = true
        button.layer.cornerRadius = radius
            return button

    }
    
}



extension NSString {
    
    class   func   stringByTrimmingCharactersInSet( string:String) ->String{
        return   string.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
    }
    
}

extension UILabel {
    
    class  func  customizedUILable( frame:CGRect , text:String , textColor:UIColor , fontSize:CGFloat ,  textAlignment:NSTextAlignment) -> UILabel{
        let lable = UILabel.init()
        lable.frame = frame
        lable.text = text
        lable.textColor = textColor
        lable.font = UIFont.systemFontOfSize(fontSize)
        lable.textAlignment = textAlignment
        lable.numberOfLines = 0
        return lable
    
    }
    
}


extension  UIView{
    class  func bezierPathWithRoundedView(view : UIView , upLeft : UIRectCorner , upRight : UIRectCorner , bottomLeft : UIRectCorner , bottomRight:UIRectCorner , cornerlayerSize:CGFloat) {
        var  maskPath : UIBezierPath = UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: upLeft , cornerRadii: CGSizeMake(cornerlayerSize, cornerlayerSize))
        
        maskPath =  UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners:  upRight , cornerRadii: CGSizeMake(cornerlayerSize, cornerlayerSize))
        maskPath =  UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners: bottomLeft  , cornerRadii: CGSizeMake(cornerlayerSize, cornerlayerSize))
        maskPath =  UIBezierPath.init(roundedRect: view.bounds, byRoundingCorners:  bottomRight, cornerRadii: CGSizeMake(cornerlayerSize, cornerlayerSize))
        let maskLayer :CAShapeLayer = CAShapeLayer.init()
        maskLayer.frame = view.bounds
        maskLayer.path = maskPath.CGPath
        view.layer.mask = maskLayer
        
    }
}










