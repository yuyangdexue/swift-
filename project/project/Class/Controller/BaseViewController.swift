//
//  BaseViewController.swift
//  project
//
//  Created by 于洋 on 16/1/6.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {
    var topView:UIView?
    
    override func viewDidLoad() {
        
        
        
        super.viewDidLoad()
        

        
        UIBarButtonItem.appearance().setBackButtonTitlePositionAdjustment(UIOffsetMake(0, -60), forBarMetrics: UIBarMetrics.Default);
        
        self.view.backgroundColor = kColor_MainBg_Color
        topView = UIView(frame:CGRectMake(0,0,kDeviceWidth,64))
        topView?.backgroundColor = kColor_Main_Color
        self.view .addSubview(topView!)
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
      
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController!.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName:UIColor.whiteColor()]

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func hideTopView( hide : Bool){
            topView?.hidden = hide
    }
    
    func  presentModalVC(viewController :UIViewController , isLeft:Bool) ->Void {
        
        let   navVc : UINavigationController =  UINavigationController.init(rootViewController: viewController)
              navVc.navigationBar.shadowImage = UIImage(named: "pixel_blank")
              navVc.navigationBar.setBackgroundImage(UIImage(named: "pixel_blank"), forBarMetrics: UIBarMetrics.Default)
              navVc.navigationBar.tintColor=UIColor.whiteColor();
        
        if   isLeft {
            viewController.navigationItem.leftBarButtonItem = UIBarButtonItem.init(title: "取消", style: UIBarButtonItemStyle.Bordered, target: self, action: "disMissModalVc")
//            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.Bordered, target: self, action: "register")

        }
        else
        {
            viewController.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "关闭", style: UIBarButtonItemStyle.Bordered, target: self, action: "disMissModalVc")

        }
        self.navigationController?.presentViewController(navVc, animated: true, completion: nil)
        
        
    }
    
    func changeTitle(title:String){
        self.title = title

      
//        self.navigationItem.titleView.t?.tintColor = UIColor.whiteColor()
    }
    

    
    func disMissModalVc(){
        self.navigationController? .dismissViewControllerAnimated(true, completion: nil)
    }


}

extension BaseViewController{
    // hud
    func dismiss() {
        LGProgressHUD.dismiss(self.view)
    }
    
    func showLoading(){
       
           LGProgressHUD.showHud("加载中...",IndeficatorType: LGProgressIndeficatorType.Custom, view: self.view)
    }
    
    func showToast( string:String , style:showStyle){
        

           LGProgressHUD.showHud(string, style: style, view: self.view)
            self .dispatchMainAfter(1.4) { () -> Void in
            self .dismiss()
        }
        

    }
    
 
    
    func   dispatchMainAfter(delay :NSTimeInterval,  block:(Void)->Void){
    
        let popTime = dispatch_time(DISPATCH_TIME_NOW,
            Int64(delay * Double(NSEC_PER_SEC))) // 1
        dispatch_after(popTime, GlobalMainQueue) { // 2
                      block()
        }

        
       
    }

    
}
