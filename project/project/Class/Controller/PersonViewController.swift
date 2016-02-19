//
//  PersonViewController.swift
//  project
//
//  Created by 于洋 on 16/1/6.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit
import ModelRocket
class PersonViewController: BaseViewController {
   
   private var array = [TabarSubModel]()
   private var tbView:UITableView?
   private var avatarImg:UIImageView?
   private var avatarLable:UILabel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
       self .hideTopView(true)
        initJson()
        addTbView()

    }
    
    func initJson(){
        let json = JSON(data:LibiaryAPI.shareInstance.dataFromResource("person", typeName: "json"))
        if let tabarModel = TabarModel(strictJSON:json){
            for subModel in  tabarModel.items{
                array.append(subModel)
            }

        }
        print(array)
    }
    
    func  addTbView(){
        
        tbView = UITableView(frame: CGRectMake(0, 0, kDeviceWidth, kDeviceHeight) ,style:UITableViewStyle.Plain)
        tbView?.delegate=self
        tbView?.dataSource=self
        self.view .addSubview(tbView!)
        tbView?.tableFooterView = UIView.init()
        tbView?.lineZero()
        addheadview()
        //tbView?.backgroundColor = UIColor.blueColor()
   

    }
    
    func addheadview(){
        
        let topView:UIView = UIView(frame:CGRectMake(0, 0, kDeviceWidth, kDeviceFactor*185))
        topView.backgroundColor = kColor_Main_Color
        avatarImg = UIImageView(frame:CGRectMake(0, 0, 60, 60))
        avatarImg?.center = CGPointMake(kDeviceWidth/2, kDeviceFactor*185/2)
        avatarImg?.image = UIImage(named: "user_personO")
        avatarImg?.userInteractionEnabled = true
        
        let  gestures :UITapGestureRecognizer = UITapGestureRecognizer.init(target: self, action: "clickAvatarImg")
        
        avatarImg?.addGestureRecognizer(gestures)
        
        topView .addSubview(avatarImg!)
       
        avatarLable = UILabel(frame:CGRectMake(0, (avatarImg?.frame.origin.y)! + (avatarImg?.frame.size.height)!+15,kDeviceWidth,30))
        avatarLable?.textAlignment = NSTextAlignment.Center
        avatarLable?.text = "请登录或注册"
        avatarLable?.textColor = UIColor.whiteColor()
        avatarLable?.font = UIFont.boldSystemFontOfSize(16)
        topView .addSubview(avatarLable!)
        tbView?.tableHeaderView = topView
        
        
        
        
    }
    
    func  clickAvatarImg(){
        
//        LibiaryAPI.shareInstance.setString("\(AppInfoKey.AppInfo_User_ID)",value: "")
        
        let userId:String = LibiaryAPI.shareInstance.getString("\(AppInfoKey.AppInfo_User_ID)")
        
        if userId.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) <= 0{
            
            let  loginVc:LoginViewController = LoginViewController()
            
            self .presentModalVC(loginVc,isLeft: true)

        }
        
    }
    
    
    
    
}

extension   PersonViewController:UITableViewDataSource{
    

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 75
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return array.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let identifier:String = "Cell"
        
        var cell: UITableViewCell! = tableView.dequeueReusableCellWithIdentifier(identifier)
        if cell == nil {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier: identifier)
        }
        let subModel = array[indexPath.row]
        cell.textLabel?.text = subModel.title.value
        cell.textLabel?.font = UIFont.boldSystemFontOfSize(14)
        cell.imageView?.image = UIImage(named: subModel.image.value!)

    return cell
    }

    
}

extension PersonViewController: UITableViewDelegate{
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        tbView?.deselectRowAtIndexPath(indexPath, animated: true)
         let subModel = array[indexPath.row]
        
        let viewController:UIViewController = LibiaryAPI.shareInstance.viewControllerWithKey(subModel.key.value!)
        viewController.title = subModel.title.value
        self.navigationController?.pushViewController(viewController, animated: true)
    }
    
    
}



