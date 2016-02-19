//
//  AppDelegate.swift
//  project
//
//  Created by 于洋 on 16/1/5.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit

var kDeviceWidth:CGFloat = 0
var kDeviceHeight:CGFloat = 0
var kDeviceFactor:CGFloat = 0
@UIApplicationMain


class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        let cframe =  UIScreen.mainScreen().bounds
        
        kDeviceWidth = cframe.size.width
        kDeviceHeight = cframe.size.height
        kDeviceFactor = kDeviceHeight <= 568.0 ? 1.0 : kDeviceHeight / 568.0
        
        self.window = UIWindow(frame: cframe)
        self.window?.backgroundColor = UIColor.blackColor()
        self.window?.clipsToBounds = true
        let  rootVc :RootViewController = RootViewController()
        
        
        
        let  navVc :UINavigationController = UINavigationController()
        navVc.navigationBar.setBackgroundImage(UIImage(named: "pixel_blank"), forBarMetrics: UIBarMetrics.Default)
        navVc.navigationBar.shadowImage=(UIImage(named: "pixel_blank"))
        navVc .pushViewController(rootVc, animated: false)
        navVc.navigationBar.barStyle = UIBarStyle.Default;
        navVc.navigationBar.tintColor = UIColor.whiteColor()
        
        
        self.window?.rootViewController = navVc
    
        self.window?.makeKeyAndVisible()
        
        
        
        return true
    }

    func applicationWillResignActive(application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(application: UIApplication) {
        // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    }


}

