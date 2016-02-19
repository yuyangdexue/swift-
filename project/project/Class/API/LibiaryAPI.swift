//
//  LibiaryAPI.swift
//  project
//
//  Created by 于洋 on 16/1/5.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit
import Alamofire


let PREFIX_URL = "http://api2015.leyue100.com/"
let APIVERSION  = "20141127"
let APICHANNEL = "baJfgkRJWgk"
let Platform = "baJfgkRJWgk"    // 客户端标示 只有单院版有用
let  Platfrom_ID = "baJfgkRJWgk" //医院所属平台ID
let  HOSPITAL_ID = "j3TTzstpa3y" // 医院ID


let isPlatformVersion :Bool = true      //是否是平台版本
let isSmallPlatformVersion : Bool = false //小平台版本

let HeaderHeight:CGFloat  = 170
let kMarginTopHeight:CGFloat = 64
let kTabBarHeight : CGFloat = 49


let kColor_Main_Color:UIColor = UIColor.colorWithHexString("fbb04c")
let kColor_Line_Color = UIColor.colorWithHexString("d3d3d3")
let kColor_MainBg_Color : UIColor = UIColor.colorWithHexString("f6f6f6")
let kColor_Black_Color: UIColor = UIColor.colorWithHexString("272727")    //黑色

let  kColor_Green_Color :UIColor =  UIColor.colorWithHexString("7bcd38")  //绿色
let  kString_Green:String = "7bcd38"
let  kString_White:String  = "ffffff"

var GlobalMainQueue: dispatch_queue_t {
    return dispatch_get_main_queue()
}


class LibiaryAPI: NSObject {

    private let httpClient: HTTPClient
    
    class var shareInstance: LibiaryAPI {
        struct Singleton {
            static let instance = LibiaryAPI()
        }
        return Singleton.instance
    }
    
    override init() {
        httpClient = HTTPClient()
         super.init()
    }
    
    func Request( isPost:Bool  , appUrl :AppUrl ,  headInfoWithUserInfo :Bool,  params: [String : AnyObject]? , blockSucess :((dicData:NSDictionary)->Void), failblock:((error:Error)->Void)){
        
        httpClient .Request(isPost,appUrl: appUrl, headInfoWithUserInfo: headInfoWithUserInfo, params: params, blockSucess: blockSucess, failblock: failblock)
        
    }
    
    func getString(key:String) -> String{
        var temp :String?
         temp = NSUserDefaults.standardUserDefaults() .valueForKey(key) as? String
       
        if temp==nil{
            return ""
        }
        else
        {
            return temp!
        }

    }
    
    func setString(key : String , value: String){
        NSUserDefaults.standardUserDefaults().setValue(value, forKey: key)
        NSUserDefaults.standardUserDefaults().synchronize()
    }

    // 读取json
    func dataFromResource(fileName:String , typeName :String ) -> NSData {
        let jsonPath = NSBundle.mainBundle().pathForResource(fileName, ofType: typeName)
        let jsonData = NSData(contentsOfFile: jsonPath!)
        
        return jsonData!
    }
    
    
    func swiftClassFromString(className: String) -> AnyClass! {
        // get the project name
        
        if  let appName: String? = NSBundle.mainBundle().objectForInfoDictionaryKey("CFBundleName") as! String? {
            // generate the full name of your class (take a look into your "YourProject-swift.h" file)
         let classStringName = "\(appName!).\(className)"
            
            // retur n the class!
            return NSClassFromString(classStringName)
        }
        return nil;
    }
   
    // 生成Controller
    func viewControllerWithKey( key:String) -> UIViewController{
        
        var  viewController:UIViewController?
        let dict:NSDictionary = [
            "main_home":"HomeViewController",
            "hospital_home":"HospitalViewController",
            "information_home":"InformationViewController",
            "personal_home":"PersonViewController",
            "patient_home" : "PatientListViewController",
            "doctor_follow" : "FollowDoctorViewController",
            "setting_home" : "SettingHomeViewController",
            "guide_home" : "SmartGuideViewController",
            "queue_list" : "QueueViewController",
            "bill_list" : "BillListViewController",
             "assay_list" : "AssayListViewController",
            "hospital_list" : "HospitalListViewController",
            "register_history": "RegistHistoryViewController"
        ]
        
        if  !(key.isEmpty){
            
            let strClass:String = (dict.objectForKey(key) as? String)!
            if (!strClass.isEmpty){
                let  controllerClass  = (LibiaryAPI.shareInstance.swiftClassFromString(strClass)) as! UIViewController.Type
                print(controllerClass)
                
                
                viewController = controllerClass.init()
            }
            
        }
        
        
        
        return viewController!
    }



    
    
}
