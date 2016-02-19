//
//  LGProgressHUD.swift
//  LGProgressHUD
//
//  Created by jamy on 12/1/15.
//  Copyright © 2015 jamy. All rights reserved.
//
// Permission is hereby granted, free of charge, to any person obtaining a copy
// of this software and associated documentation files (the "Software"), to deal
// in the Software without restriction, including without limitation the rights
// to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
// copies of the Software, and to permit persons to whom the Software is
// furnished to do so, subject to the following conditions:
//
// The above copyright notice and this permission notice shall be included in
// all copies or substantial portions of the Software.
//
// THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
// IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
// FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
// AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
// LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
// OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
// THE SOFTWARE.

import UIKit

public enum showStyle {
    case Success
    case Error
    case Warning
    case None
    case CustomImage(imageName:String)
}

public enum LGProgressIndeficatorType {
    case System
    case Custom
    
    func indeficatorView() ->UIView {
        var indeficatorView: UIView?
        switch self{
        case .Custom:
            indeficatorView = CustomIndeficatorView()
        case .System:
            indeficatorView = UIActivityIndicatorView(activityIndicatorStyle: .WhiteLarge)
            indeficatorView!.sizeToFit()
            (indeficatorView as! UIActivityIndicatorView).color = UIColor.whiteColor()
        }
        
        return indeficatorView!
    }
}

// MARK: just call below class function
extension LGProgressHUD {
    // MARK: class function
    
    public class func dismiss(view: UIView = UIApplication.sharedApplication().keyWindow!) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            for view in view.subviews {
                if view.isKindOfClass(LGProgressHUD.self) {
                    let hud = view as! LGProgressHUD
                    hud.hiddenView(0)
                }
            }
        }
    }
    
    public class func showHud(title: String = "", style: showStyle = .None, view: UIView = UIApplication.sharedApplication().keyWindow!) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let hud = LGProgressHUD()
            hud.show(title, style: style, view: view)
        }
    }

    public class func showHud(hiddenDelay: NSTimeInterval, title: String = "", style: showStyle = .None, view: UIView = UIApplication.sharedApplication().keyWindow!) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let hud = LGProgressHUD()
            hud.show(title, style: style, view: view)
            
            hud.hiddenView(hiddenDelay)
        }
    }
    
    public class func showHud(title: String = "", IndeficatorType: LGProgressIndeficatorType = .System, view: UIView = UIApplication.sharedApplication().keyWindow!) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let hud = LGProgressHUD()
            hud.indeficatorType = IndeficatorType
            hud.show(title, view: view)
        }
    }
    
    public class func showHud(hiddenDelay: NSTimeInterval, title: String = "", IndeficatorType: LGProgressIndeficatorType = .System, view: UIView = UIApplication.sharedApplication().keyWindow!) {
        dispatch_async(dispatch_get_main_queue()) { () -> Void in
            let hud = LGProgressHUD()
            hud.indeficatorType = IndeficatorType
            hud.show(title, view: view)
            
            hud.hiddenView(hiddenDelay)
        }
    }
}


private let defaultAnimaitonHeight: CGFloat = 80

@available(iOS 8.0, *)
public class LGProgressHUD: UIView {
    
    let maxContentViewSize = CGSizeMake(3.0 * defaultAnimaitonHeight, 3.0 * defaultAnimaitonHeight)
    let topMargin: CGFloat = 10
    let horzriedMargin: CGFloat = 10
    
    var contentView = UIView()
    var titleLabel = UILabel()
    
    var imageView: UIImageView?
    var animationView: UIView?
    
    var hudColor: UIColor?
    var contentViewColor: UIColor?
    var titleColor: UIColor?
    
    var indeficatorType = LGProgressIndeficatorType.Custom
    
    // MARK: - lifecycle
    init() {
        super.init(frame: UIScreen.mainScreen().bounds)
        setup()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
    deinit {
        NSLog("deinit")
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    private func setup() {
        self.autoresizingMask = [.FlexibleLeftMargin, .FlexibleRightMargin, .FlexibleTopMargin, .FlexibleBottomMargin]
        self.backgroundColor = UIColor.clearColor()
    }
    
    private func setupContentView() {
        contentView.layer.cornerRadius = 8.0
        contentView.layer.masksToBounds = true
        contentView.backgroundColor = UIColor(hexString: "1E2028", alpha: 0.9)
        self.addSubview(contentView)
        contentView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupTitleLabel() {
        titleLabel.textAlignment = .Center
        titleLabel.numberOfLines = 1
        titleLabel.text = ""
        titleLabel.baselineAdjustment = .AlignCenters
        titleLabel.backgroundColor = UIColor.clearColor()
        titleLabel.adjustsFontSizeToFitWidth = true
        titleLabel.font = UIFont.boldSystemFontOfSize(15.0)
        titleLabel.textColor = UIColor.whiteColor()
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(titleLabel)
    }
    
    private func setupAnimateView() {
        if let animateView = self.animationView {
            contentView.addSubview(animateView)
            animateView.translatesAutoresizingMaskIntoConstraints = false
        }
    }
    
    private func setupImageView(image: UIImage) {
        imageView = UIImageView()
        imageView?.image = image
        imageView?.contentMode = .ScaleAspectFit
        contentView.addSubview(imageView!)
        imageView?.translatesAutoresizingMaskIntoConstraints = false
    }
    
    // MARK: show function
    public func show(view: UIView = UIApplication.sharedApplication().keyWindow!) {
        return show("", view: view)
    }
    
    public func show(title: String, view: UIView = UIApplication.sharedApplication().keyWindow!) {
        return show(title, style: .None, view: view)
    }
    
    public func show(style: showStyle, view: UIView = UIApplication.sharedApplication().keyWindow!) {
        return show("", style: style, view: view)
    }
    
    public func show(title: String, style: showStyle, view: UIView = UIApplication.sharedApplication().keyWindow!) {
        for subView in view.subviews {
            if subView.isKindOfClass(LGProgressHUD.self) {
                subView.removeFromSuperview()
            }
        }
        
        self.frame = view.bounds
        view.addSubview(self)
        view.bringSubviewToFront(self)
        
        setupContentView()
        
        if title.characters.count > 0 {
            setupTitleLabel()
            self.titleLabel.text = title
        }
        
        switch style {
        case .Success:
            animationView = successfulAnimation()
        case .Warning:
            animationView = WarningAnimation()
        case .Error:
            animationView = ErrorAnimation()
        case let .CustomImage(imageName):
            if let image = UIImage(named: imageName) {
                self.setupImageView(image)
            }
        case .None:
            animationView = indeficatorType.indeficatorView()
        }
        
        setupAnimateView()
        updateLayout()
        showHudAnimated()
    }
    
    private func showHudAnimated() {
        self.alpha = 0;
        UIView.animateWithDuration(0.1, animations: { () -> Void in
            self.alpha = 1.0;
        })
        
        let previousTransform = self.contentView.transform
        self.contentView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.0);
        UIView.animateWithDuration(0.2, animations: { () -> Void in
            self.contentView.layer.transform = CATransform3DMakeScale(1.1, 1.1, 0.0);
            }) { (Bool) -> Void in
                UIView.animateWithDuration(0.1, animations: { () -> Void in
                    self.contentView.layer.transform = CATransform3DMakeScale(0.9, 0.9, 0.0);
                    }) { (Bool) -> Void in
                        UIView.animateWithDuration(0.1, animations: { () -> Void in
                            self.contentView.layer.transform = CATransform3DMakeScale(1.0, 1.0, 0.0);
                            if case let animate as AnimationView = self.animationView {
                                animate.animated()
                            } else if case let animate as UIActivityIndicatorView = self.animationView {
                                animate.startAnimating()
                            }
                            
                            }) { (Bool) -> Void in
                                self.contentView.transform = previousTransform
                        }
                }
        }
    }
    
    // MARK: hidden
    
    public func hiddenView(delay: NSTimeInterval) {
        performSelector("hiddenView", withObject: self, afterDelay: delay)
    }
    
    public func hiddenView() {
        UIView.animateWithDuration(0.15, delay: 0, options: .CurveEaseIn, animations: { () -> Void in
            self.contentView.transform = CGAffineTransformMakeScale(0.8, 0.8)
            }) { (_) -> Void in
                self.contentView.alpha = 0
                if let animated = self.animationView {
                    animated.removeFromSuperview()
                }
                if let imageView = self.imageView {
                    imageView.removeFromSuperview()
                }
                self.contentView.removeFromSuperview()
                self.removeFromSuperview()
        }
    }
    
    // MARK: layout
    
    private func updateLayout() {
        self.frame = UIScreen.mainScreen().bounds
        var verturlMargin: CGFloat = 0
        var contentWidth: CGFloat = defaultAnimaitonHeight + 2.0 * topMargin
        
        if let imageView = self.imageView {
            if contentView.subviews.contains(imageView) {
                contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: topMargin))
                contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: horzriedMargin))
                contentView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: -horzriedMargin))
                let tempWidth = imageView.image?.size.height
                let width = tempWidth! > defaultAnimaitonHeight ? defaultAnimaitonHeight : tempWidth!
                imageView.addConstraint(NSLayoutConstraint(item: imageView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: width))
                verturlMargin = width + topMargin
            }
        }
        
        if let animationView = self.animationView {
            if contentView.subviews.contains(animationView) {
                contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: topMargin))
                contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .CenterX, relatedBy: .Equal, toItem: contentView, attribute: .CenterX, multiplier: 1, constant: 0))
                contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: defaultAnimaitonHeight))
                contentView.addConstraint(NSLayoutConstraint(item: animationView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: defaultAnimaitonHeight))
                verturlMargin = defaultAnimaitonHeight + topMargin
            }
        }
        
        if contentView.subviews.contains(titleLabel) {
            contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: horzriedMargin))
            contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: -horzriedMargin))
            contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: verturlMargin))
            contentView.addConstraint(NSLayoutConstraint(item: titleLabel, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: -topMargin))
            verturlMargin = verturlMargin + topMargin
            
            if let string = titleLabel.text {
                let str = string as NSString
                let strRect = str.boundingRectWithSize(CGSizeMake(maxContentViewSize.width, 200), options: NSStringDrawingOptions(rawValue: NSStringDrawingOptions.TruncatesLastVisibleLine.rawValue | NSStringDrawingOptions.UsesFontLeading.rawValue), attributes: [NSFontAttributeName : titleLabel.font], context: nil)
                verturlMargin = verturlMargin + strRect.height
                
                if strRect.width > contentWidth {
                    contentWidth = strRect.width < maxContentViewSize.width ? strRect.width : maxContentViewSize.width
                }
            }
        }
        
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .CenterX, relatedBy: .Equal, toItem: self, attribute: .CenterX, multiplier: 1, constant: 0))
        self.addConstraint(NSLayoutConstraint(item: contentView, attribute: .CenterY, relatedBy: .Equal, toItem: self, attribute: .CenterY, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Height, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: verturlMargin + topMargin))
        contentView.addConstraint(NSLayoutConstraint(item: contentView, attribute: .Width, relatedBy: .Equal, toItem: nil, attribute: .NotAnAttribute, multiplier: 1, constant: contentWidth))
        
       // updateBlueEffect()
    }
    
    private func updateBlueEffect() {
        for subView in contentView.subviews {
            if subView.isKindOfClass(UIVisualEffectView.self) {
                subView.removeFromSuperview()
            }
        }
        
        let blueStyle = UIBlurEffectStyle.Light
        let blueEffect = UIBlurEffect(style: blueStyle)
        let blueEffectView = UIVisualEffectView(effect: blueEffect)
        blueEffectView.autoresizingMask = contentView.autoresizingMask
      
        let vibrancyEffect = UIVibrancyEffect(forBlurEffect: blueEffect)
        let vibrancyEffectView = UIVisualEffectView(effect: vibrancyEffect)
        vibrancyEffectView.autoresizingMask = blueEffectView.autoresizingMask
        blueEffectView.contentView.addSubview(vibrancyEffectView)
        
        self.contentView.insertSubview(blueEffectView, atIndex: 0)
        blueEffectView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addConstraint(NSLayoutConstraint(item: blueEffectView, attribute: .Top, relatedBy: .Equal, toItem: contentView, attribute: .Top, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: blueEffectView, attribute: .Left, relatedBy: .Equal, toItem: contentView, attribute: .Left, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: blueEffectView, attribute: .Bottom, relatedBy: .Equal, toItem: contentView, attribute: .Bottom, multiplier: 1, constant: 0))
        contentView.addConstraint(NSLayoutConstraint(item: blueEffectView, attribute: .Right, relatedBy: .Equal, toItem: contentView, attribute: .Right, multiplier: 1, constant: 0))
    }
    
}

// MARK: - UIColor Extension
extension UIColor {
    
    convenience init?(hexString: String, alpha: Float = 1) {
        var hex = hexString
        
        if hex.hasPrefix("#") {
            hex = hex.substringFromIndex(hex.startIndex.advancedBy(1))
        }
        
        if let _ = hex.rangeOfString("(^[0-9A-Fa-f]{6}$)|(^[0-9A-Fa-f]{3}$)", options: .RegularExpressionSearch) {
            if hex.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) == 3 {
                let redHex = hex.substringToIndex(hex.startIndex.advancedBy(1))
                let greenHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(1), end: hex.startIndex.advancedBy(2)))
                let blueHex = hex.substringFromIndex(hex.startIndex.advancedBy(2))
                hex = redHex + redHex + greenHex + greenHex + blueHex + blueHex
            }
            let redHex = hex.substringToIndex(hex.startIndex.advancedBy(2))
            let greenHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(2), end: hex.startIndex.advancedBy(4)))
            let blueHex = hex.substringWithRange(Range<String.Index>(start: hex.startIndex.advancedBy(4), end: hex.startIndex.advancedBy(6)))
            
            var redInt:   CUnsignedInt = 0
            var greenInt: CUnsignedInt = 0
            var blueInt:  CUnsignedInt = 0
            
            NSScanner(string: redHex).scanHexInt(&redInt)
            NSScanner(string: greenHex).scanHexInt(&greenInt)
            NSScanner(string: blueHex).scanHexInt(&blueInt)
            
            self.init(red: CGFloat(redInt) / 255.0, green: CGFloat(greenInt) / 255.0, blue: CGFloat(blueInt) / 255.0, alpha: CGFloat(alpha))
        }
        else
        {
            self.init()
            return nil
        }
    }
    
    convenience init?(hex: Int, alpha: Float = 1) {
        let hexString = NSString(format: "%2X", hex)
        self.init(hexString: hexString as String, alpha: alpha)
    }
}

// MARK: animation layer

 class AnimationView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setup()
    }
    
     func angle(value: Double) -> CGFloat {
        return CGFloat((value) / 180.0 * M_PI)
    }
    
    func setup() {
        
    }
    
    func animated() {
        
    }
}

class CustomIndeficatorView: AnimationView {
    var circleLayer: CAShapeLayer!
    var maskLayer: CALayer!
    
    var circlePath: CGPath {
        let path = UIBezierPath()
        let startAngle = angle(0)
        let endAngle = angle(700)
        path.addArcWithCenter(CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2), radius: defaultAnimaitonHeight / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        return path.CGPath
    }
    
    override func setup() {
        circleLayer = CAShapeLayer()
        circleLayer.position = CGPointZero
        circleLayer.path = circlePath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(hexString: "00FF00")?.CGColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = 2.0
    }
    
    override func animated() {
        
         maskLayer = CALayer()
        let gradientLayer = CAGradientLayer()
        gradientLayer.colors = [UIColor.blackColor().CGColor, UIColor.whiteColor().CGColor]
        gradientLayer.startPoint = CGPointMake(0, 1)
        gradientLayer.endPoint = CGPointMake(1, 1)
        gradientLayer.frame = CGRectMake(-4, -4, defaultAnimaitonHeight + 8, defaultAnimaitonHeight + 8)
        
        maskLayer.addSublayer(gradientLayer)
        maskLayer.mask = circleLayer
        self.layer.addSublayer(maskLayer)
        
        let roteAnimation = CABasicAnimation(keyPath: "transform.rotation")
        roteAnimation.fromValue = 0
        roteAnimation.toValue = 2.0 * M_PI
        roteAnimation.duration = 1
        roteAnimation.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        roteAnimation.repeatCount = HUGE
        roteAnimation.fillMode = kCAFillModeForwards
        roteAnimation.removedOnCompletion = false
        gradientLayer.addAnimation(roteAnimation, forKey: "rote")
        
        let animationGroup = CAAnimationGroup()
        animationGroup.duration = 1.0
        animationGroup.repeatCount = HUGE
        animationGroup.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionLinear)
        animationGroup.fillMode = kCAFillModeForwards
        animationGroup.removedOnCompletion = false
        
        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        strokeStart.fromValue = 0.025
        strokeStart.toValue = 0.525

        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.fromValue = 0.475
        strokeEnd.toValue = 0.975
        
        animationGroup.animations = [strokeStart, strokeEnd]
        self.circleLayer.addAnimation(animationGroup, forKey: "stroke")
    }
}

class successfulAnimation: AnimationView {
    
    var circleLayer: CAShapeLayer!
    var animateLayer: CAShapeLayer!
    
    var animatePath: CGPath {
        let path = UIBezierPath()
        let startAngle = angle(60)
        let endAngle = angle(200)
        path.addArcWithCenter(CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2), radius: defaultAnimaitonHeight / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        path.addLineToPoint(CGPoint(x: 36.0 - 10.0 ,y: 60.0 - 10.0))
        path.addLineToPoint(CGPoint(x: 85.0 - 20.0, y: 30.0 - 20.0))
        return path.CGPath
    }
    
    var circlePath: CGPath {
        let path = UIBezierPath()
        let startAngle = angle(0)
        let endAngle = angle(360)
        path.addArcWithCenter(CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2), radius: defaultAnimaitonHeight / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path.CGPath
    }
    
    override func setup() {
        circleLayer = CAShapeLayer()
        circleLayer.position = CGPointZero
        circleLayer.path = circlePath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(hexString: "F2A665")?.CGColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = 4.0
        
        animateLayer = CAShapeLayer()
        animateLayer.position = CGPointZero
        animateLayer.path = animatePath
        animateLayer.fillColor = UIColor.clearColor().CGColor
        animateLayer.strokeColor = UIColor.greenColor().CGColor
        animateLayer.lineCap = kCALineCapRound
        animateLayer.lineWidth = 4.0
        animateLayer.actions = [
            "strokeStart": NSNull(),
            "strokeEnd": NSNull(),
            "transform": NSNull()
        ]
        
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(animateLayer)
        animateLayer.strokeStart = 0.0
        animateLayer.strokeEnd = 0.0
    }
    
    override func animated() {
        let strokeStart = CABasicAnimation(keyPath: "strokeStart")
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        let facetor = 0.04
        strokeEnd.fromValue = 0.0
        strokeEnd.toValue = 0.95
        strokeEnd.duration = 10.0 * facetor
        strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.3, 0.6, 0.8, 1.2)
        
        strokeStart.fromValue = 0.0
        strokeStart.toValue = 0.70
        strokeStart.duration = 7.0 * facetor
        strokeStart.beginTime = CACurrentMediaTime() + 3.0 * facetor
        strokeStart.fillMode = kCAFillModeBackwards
        strokeStart.timingFunction = CAMediaTimingFunction(controlPoints: 0.3, 0.6, 0.8, 1.2)
        
        animateLayer.strokeStart = 0.70
        animateLayer.strokeEnd = 0.95
        animateLayer.addAnimation(strokeEnd, forKey: "strokeEnd")
        animateLayer.addAnimation(strokeStart, forKey: "strokeStart")
        
        let strokeColor = CABasicAnimation(keyPath: "strokeColor")
        strokeColor.fromValue = UIColor(hexString: "F7D58B")?.CGColor
        strokeColor.toValue = UIColor(hexString: "F2A665")?.CGColor
        strokeColor.duration = 1.5
        strokeColor.repeatCount = HUGE
        strokeColor.autoreverses = true
        strokeColor.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.addAnimation(strokeColor, forKey: "strokeColor")
    }
}


class WarningAnimation: AnimationView {
    
    var circleLayer: CAShapeLayer!
    var animateLayer: CAShapeLayer!
    
    var animatePath: CGPath {
        let path = UIBezierPath()
        let startAngle = angle(90)
        let endAngle = angle(450)
        path.addArcWithCenter(CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2), radius: defaultAnimaitonHeight / 2, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        
        let length = defaultAnimaitonHeight / 1.5
        path.moveToPoint(CGPointMake(defaultAnimaitonHeight / 2, 15))
        path.addLineToPoint(CGPointMake(defaultAnimaitonHeight / 2, length))
        path.moveToPoint(CGPointMake(defaultAnimaitonHeight / 2, length + 10))
        
        path.addArcWithCenter(CGPointMake(defaultAnimaitonHeight / 2, length + 10), radius: 1.0, startAngle: angle(0), endAngle: angle(360), clockwise: false)
        
        return path.CGPath
    }
    
    var circlePath: CGPath {
        let path = UIBezierPath()
        let startAngle = angle(0)
        let endAngle = angle(360)
        path.addArcWithCenter(CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2), radius: defaultAnimaitonHeight / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path.CGPath
    }
    
    override func setup() {
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(hexString: "F2A665")?.CGColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = 4.0
        
        animateLayer = CAShapeLayer()
        animateLayer.path = animatePath
        animateLayer.fillColor = UIColor.clearColor().CGColor
        animateLayer.strokeColor = UIColor.yellowColor().CGColor
        animateLayer.lineCap = kCALineCapRound
        animateLayer.lineWidth = 4.0
        animateLayer.frame = CGRectMake(0, 0, defaultAnimaitonHeight, defaultAnimaitonHeight)
        animateLayer.position = CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2)
        
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(animateLayer)
        animateLayer.strokeStart = 0.0
        animateLayer.strokeEnd = 0.0
    }
    
    override func animated() {
        let strokeEnd = CABasicAnimation(keyPath: "strokeEnd")
        strokeEnd.fromValue = 0.0
        strokeEnd.toValue = 1.0
        strokeEnd.duration = 0.3
        strokeEnd.fillMode = kCAFillModeForwards
        strokeEnd.removedOnCompletion = false
        strokeEnd.timingFunction = CAMediaTimingFunction(controlPoints: 0.3, 0.6, 0.8, 1.2)
        
        animateLayer.addAnimation(strokeEnd, forKey: "strokeEnd")
        
        let roteAnimation = CAKeyframeAnimation(keyPath: "transform")
        roteAnimation.beginTime = CACurrentMediaTime() + 0.3
        roteAnimation.duration =  0.3
        roteAnimation.values = [
            NSValue(CATransform3D: CATransform3DMakeRotation(angle(-30), 0, 0, 1)),
            NSValue(CATransform3D: CATransform3DMakeRotation(angle(30), 0, 0, 1)),
            NSValue(CATransform3D: CATransform3DMakeRotation(angle(-30), 0, 0, 1)),
            NSValue(CATransform3D: CATransform3DIdentity)
        ]
        roteAnimation.fillMode = kCAFillModeForwards
        roteAnimation.removedOnCompletion = false
        animateLayer.addAnimation(roteAnimation, forKey: "rote")
        
        let strokeColor = CABasicAnimation(keyPath: "strokeColor")
        strokeColor.fromValue = UIColor(hexString: "F7D58B")?.CGColor
        strokeColor.toValue = UIColor(hexString: "F2A665")?.CGColor
        strokeColor.duration = 1.5
        strokeColor.repeatCount = HUGE
        strokeColor.autoreverses = true
        strokeColor.timingFunction = CAMediaTimingFunction(name: kCAMediaTimingFunctionEaseInEaseOut)
        circleLayer.addAnimation(strokeColor, forKey: "strokeColor")
    }
}

class ErrorAnimation: AnimationView {
    
    var circleLayer: CAShapeLayer!
    var animateLayer: CAShapeLayer!
    
    var animatePath: CGPath {
        let path = UIBezierPath()
        
        let factor:CGFloat = defaultAnimaitonHeight / 5.0
        path.moveToPoint(CGPoint(x: defaultAnimaitonHeight/2.0-factor,y: defaultAnimaitonHeight/2.0-factor))
        path.addLineToPoint(CGPoint(x: defaultAnimaitonHeight/2.0+factor,y: defaultAnimaitonHeight/2.0+factor))
        path.moveToPoint(CGPoint(x: defaultAnimaitonHeight/2.0+factor,y: defaultAnimaitonHeight/2.0-factor))
        path.addLineToPoint(CGPoint(x: defaultAnimaitonHeight/2.0-factor,y: defaultAnimaitonHeight/2.0+factor))
        
        return path.CGPath
    }
    
    var circlePath: CGPath {
        let path = UIBezierPath()
        let startAngle = angle(0)
        let endAngle = angle(360)
        path.addArcWithCenter(CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2), radius: defaultAnimaitonHeight / 2.0, startAngle: startAngle, endAngle: endAngle, clockwise: false)
        return path.CGPath
    }
    
    override func setup() {
        circleLayer = CAShapeLayer()
        circleLayer.path = circlePath
        circleLayer.fillColor = UIColor.clearColor().CGColor
        circleLayer.strokeColor = UIColor(hexString: "F2A665")?.CGColor
        circleLayer.lineCap = kCALineCapRound
        circleLayer.lineWidth = 4.0
        circleLayer.frame = CGRectMake(0, 0, defaultAnimaitonHeight, defaultAnimaitonHeight)
        circleLayer.position = CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2)
        
        animateLayer = CAShapeLayer()
        animateLayer.path = animatePath
        animateLayer.fillColor = UIColor.clearColor().CGColor
        animateLayer.strokeColor = UIColor.redColor().CGColor
        animateLayer.lineCap = kCALineCapRound
        animateLayer.lineWidth = 4.0
        animateLayer.frame = CGRectMake(0, 0, defaultAnimaitonHeight, defaultAnimaitonHeight)
        animateLayer.position = CGPointMake(defaultAnimaitonHeight / 2, defaultAnimaitonHeight / 2)
        
        self.layer.addSublayer(circleLayer)
        self.layer.addSublayer(animateLayer)
        
        var t = CATransform3DIdentity;
        t.m34 = 1.0 / -500.0;
        t = CATransform3DRotate(t, CGFloat(90.0 * M_PI / 180.0), 1, 0, 0);
        circleLayer.transform = t
        
        animateLayer.opacity = 0.0
    }
    
    override func animated() {
        var t = CATransform3DIdentity;
        t.m34 = 1.0 / -500.0;
        t = CATransform3DRotate(t, CGFloat(90.0 * M_PI / 180.0), 1, 0, 0);
        
        var t2 = CATransform3DIdentity;
        t2.m34 = 1.0 / -500.0;
        t2 = CATransform3DRotate(t2, CGFloat(-M_PI), 1, 0, 0);
        
        let animation = CABasicAnimation(keyPath: "transform")
        let time = 0.3
        animation.duration = time;
        animation.fromValue = NSValue(CATransform3D: t)
        animation.toValue = NSValue(CATransform3D:t2)
        animation.removedOnCompletion = false
        animation.fillMode = kCAFillModeForwards
        self.circleLayer.addAnimation(animation, forKey: "transform")
        
        var scale = CATransform3DIdentity;
        scale = CATransform3DScale(scale, 0.3, 0.3, 0)

        let crossAnimation = CABasicAnimation(keyPath: "transform")
        crossAnimation.duration = 0.3;
        crossAnimation.beginTime = CACurrentMediaTime() + time
        crossAnimation.fromValue = NSValue(CATransform3D: scale)
        crossAnimation.timingFunction = CAMediaTimingFunction(controlPoints: 0.25, 0.8, 0.7, 2.0)
        crossAnimation.toValue = NSValue(CATransform3D:CATransform3DIdentity)
        animateLayer.addAnimation(crossAnimation, forKey: "scale")
        
        
        let fadeInAnimation = CABasicAnimation(keyPath: "opacity")
        fadeInAnimation.duration = 0.3;
        fadeInAnimation.beginTime = CACurrentMediaTime() + time
        fadeInAnimation.fromValue = 0.3
        fadeInAnimation.toValue = 1.0
        fadeInAnimation.removedOnCompletion = false
        fadeInAnimation.fillMode = kCAFillModeForwards
        animateLayer.addAnimation(fadeInAnimation, forKey: "opacity")
    }
}


class progressAnimation: AnimationView {
    
}


