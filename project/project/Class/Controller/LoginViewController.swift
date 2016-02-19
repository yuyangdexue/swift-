//
//  LoginViewController.swift
//  project
//
//  Created by 于洋 on 16/1/7.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit

class LoginViewController: BaseViewController {
  
    var iphoneImg:UIImageView?
    var iphoneTextFiled:UITextField?
    var passwordImg:UIImageView?
    var passwordTextFiled:UITextField?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self .changeTitle("登录")
        self.navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "注册", style: UIBarButtonItemStyle.Bordered, target: self, action: "register")
        initBasicView()
    }
    
    func initBasicView(){
        let height:CGFloat = 50
        let originX :CGFloat = 15
        let originY :CGFloat = 64
        let bgView:UIView = UIView(frame:CGRectMake(0, originY, kDeviceWidth, 100))
        bgView.backgroundColor = UIColor.whiteColor()
        
        iphoneImg = UIImageView.customizedImageView( CGRectMake(originX, originY+(height-20)/2, 20, 20),imageName: "login_phone")
        iphoneTextFiled = UITextField.customizedUITextField(CGRectMake(2*originX+20, originY+(height-20)/2, kDeviceWidth-3*originX-20, 20), text: "", palceholder: "请输入您的手机号", textColor: UIColor.whiteColor(), fontSize: 14, textAlignment: NSTextAlignment.Left)
        
        let line:UIView = UIView(frame:CGRectMake(0, originY+50-0.5, kDeviceWidth, 0.5) )
        line.backgroundColor = kColor_Line_Color
        
        
        passwordImg = UIImageView.customizedImageView( CGRectMake(originX, originY+(height-20)/2+50, 20, 20),imageName: "login_code")
        passwordTextFiled = UITextField.customizedUITextField(CGRectMake(2*originX+20, originY+(height-20)/2+50, kDeviceWidth-3*originX-20, 20), text: "", palceholder: "请输入您的密码", textColor: UIColor.whiteColor(), fontSize: 14, textAlignment: NSTextAlignment.Left)

        let line1:UIView = UIView(frame:CGRectMake(0, originY+50+50-0.5, kDeviceWidth, 0.5) )
        line1.backgroundColor = kColor_Line_Color
        
        let  forgetBtn : UIButton = UIButton.customizedButton(CGRectMake(kDeviceWidth-90, originY+(height-30)/2+50, 75, 30), title: "忘记密码", titleColorString: kString_Green, titleFont: 12, radius: 1, backgroundImageColorString: kString_White, clickAction: "forgetPassWord", viewController: self)

        
        let loginBtn : UIButton = UIButton.customizedButton(CGRectMake(originX, originY+100+15, kDeviceWidth-30, 40), title: "登录", titleColorString: kString_White, titleFont: 16, radius: 20, backgroundImageColorString: kString_Green, clickAction: "login", viewController: self)
        
        self.view .addSubview(bgView)
        self.view  .addSubview(iphoneImg!)
        self.view  .addSubview(iphoneTextFiled!)
        self.view .addSubview(line)
        self.view .addSubview(passwordImg!)
        self.view .addSubview(passwordTextFiled!)
        self.view .addSubview(line1)
        self.view .addSubview(forgetBtn)
        self.view .addSubview(loginBtn)
        iphoneTextFiled?.becomeFirstResponder()

    }
    

    

    
    func register(){
        
        let registerVC = RegisterViewController()
        self.navigationController?.pushViewController(registerVC, animated: true)
        
    }
    

    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}

extension  LoginViewController{
    // 登录事件
    func login(){
        let iphone :String = NSString.stringByTrimmingCharactersInSet((iphoneTextFiled?.text)!)
        let password :String = NSString.stringByTrimmingCharactersInSet((passwordTextFiled?.text)!)
        
        if (iphone.characters.count == 0){
            self.showToast("请输入手机号",style:showStyle.Warning )
            
            iphoneTextFiled?.resignFirstResponder()
            return
        }
        
        if (password.characters.count == 0){
            self.showToast("请输入手机号",style:showStyle.Warning)
            passwordTextFiled?.becomeFirstResponder()
        }
        
        //LibiaryAPI.shareInstance.Request(true, appUrl:AppUrl.AppURL_Login , headInfoWithUserInfo: <#T##Bool#>, params: <#T##[String : AnyObject]?#>, blockSucess: <#T##((dicData: NSDictionary) -> Void)##((dicData: NSDictionary) -> Void)##(dicData: NSDictionary) -> Void#>, failblock: <#T##((error: Error) -> Void)##((error: Error) -> Void)##(error: Error) -> Void#>)
        
    }
    
    //忘记密码
    func forgetPassWord(){
        
    }
}


