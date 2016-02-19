//
//  RootViewController.swift
//  project
//
//  Created by 于洋 on 16/1/6.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit
import ModelRocket

class RootViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.initSubView()
        self.view.backgroundColor = UIColor.orangeColor()
        // Do any additional setup after loading the view.
    }
    
    
    func initSubView(){
        
        self.tabBar.tintColor=kColor_Main_Color
        
        
        var controllers = [UIViewController]()
        
        let json = JSON(data:LibiaryAPI.shareInstance.dataFromResource("plat_rootTabs", typeName: "json"))
        if let tabarModel = TabarModel(strictJSON:json){
            for model in tabarModel.items {
      
                let viewController:UIViewController = LibiaryAPI.shareInstance.viewControllerWithKey(model.key.value!)
                
               
                for   submodel in model.subitems{
                    let customItem:UITabBarItem = UITabBarItem.init(title: submodel.title.value, image:  UIImage(named: submodel.image.value!)   , selectedImage:  UIImage(named: submodel.image_hl.value!))
                    customItem.imageInsets = UIEdgeInsetsMake(-3, 0, 3, 0)
                    //customItem.titlePositionAdjustment(UIOffsetMake(0, -5))
                    customItem.setTitleTextAttributes([NSFontAttributeName: UIFont.boldSystemFontOfSize(12)], forState: UIControlState.Normal)
                    
                    viewController.navigationController?.navigationBarHidden = true
                    viewController.tabBarItem = customItem
                }
                
                viewController.title = model.title.value
                 controllers.append(viewController)
            }

           
    }
         self.viewControllers = controllers
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}
