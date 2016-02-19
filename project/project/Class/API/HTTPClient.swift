//
//  HTTPClient.swift
//  project
//
//  Created by 于洋 on 16/1/5.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit
import Alamofire


enum AppUrl: NSInteger {
    case
    AppURL_Alpha = 1000,
    AppURL_Setting,
    AppURL_Website,
    AppURL_HomeInfo,
    AppURL_SMSCode,
    AppURL_BPush_Renew,
    AppURL_Login,
    AppURL_SkipToken,
    AppURL_SkipLogin,
    AppURL_Logout,
    AppURL_Register,
    AppURL_TicketRegister,
    AppURL_GetTicket,
    AppURL_ResetPwd,
    AppURL_ResetPwd_SMS,
    AppURL_Guides,
    AppURL_Departments,
    AppURL_Doctor_Recent,
    AppURL_Doctor_Detail,
    AppURL_Doctor_ByDate,
    AppURL_Doctor_Search,
    AppURL_Doctor_FollowCheck,
    AppURL_Doctor_FollowAdd,
    AppURL_Doctor_FollowRemove,
    AppURL_Doctor_FollowList,
    AppURL_Hospital_Info,
    AppURL_Hospital_Config,
    AppURL_PatientAdd,
    AppURL_PatientRemove,
    AppURL_PatientUpdate,
    AppURL_PatientList,
    AppURL_PatientAutoCode,
    AppURL_TicketList,
    AppURL_TicketDetail,
    APPURL_TicketCancel,
    APPURL_ScheduleDetail,
    AppURL_MessageList,
    AppURL_MessageDetail,
    AppURL_MessageDelete,
    AppURL_AssayList,
    AppURL_AssayDetail,
    AppURL_QueueList,
    AppURL_HospitalList,
    AppURL_Search_City,
    AppURL_HospitalOnlineList,
    AppURL_HospitalTask,
    AppURL_Upgrade,
    AppURL_ScheduleCalendar,
    AppURL_SearchAll,
    AppURL_Search_Department,
    AppURL_Feedback_Add,
    AppURL_Information_Home,
    AppURL_Information_List,
    AppURL_Information_DoctorList,
    AppURL_Information_MicroStation,
    AppURL_Message_Catalog,
    AppURL_Message_GetAll,
    AppURL_Website_Home,
    AppURL_Department_Website,
    AppURL_Website_HospitalHome,
    AppURL_Website_ServiceList,
    AppURL_Information_Detail,
    AppURL_Select_City,
    AppURL_Website_HospitalDetail,
    AppURL_Website_DoctorList,
    AppURL_Assay_GetAll,
    AppURL_Pay_List,
    AppURL_Pay_Detail,
    AppURL_Hospital_TimeLine,
    AppURL_Hospital_CheckRequire,
    AppURL_Patient_getHospital,
    AppURL_Seview_view,
    
    AppInfo_Reg_OrderNO,
    AppURL_Pay_Check,
    AppURL_Pay_Waiting,
    
    AppURL_Status_Read,
    
    AppURL_Config_Get,
    AppURL_Guide_Department,
    AppURL_Department_Inteligent,
    
    AppURL_WXLogin,
    
    AppURL_Zero
}

enum AppInfoKey: NSInteger{
    
    case
    AppInfo_Alpha = 2000,
    AppInfo_User_ID,
    AppInfo_User_Name,
    AppInfo_User_Phone,
    AppInfo_User_Pwd,
    AppInfo_User_Token,
    AppInfo_User_LoginTime,
    AppInfo_User_IsWXAppInstalled,//是否安装微信
    
    AppInfo_Device_UDID,
    AppInfo_Device_PushToken,
    AppInfo_Device_Binded,
    
    AppInfo_BPush_UserID,
    AppInfo_BPush_AppID,
    AppInfo_BPush_Channel,
    
    AppInfo_Reg_DoctorId,
    AppInfo_Reg_DoctorName,
    AppInfo_Reg_DoctorTitle,
    AppInfo_Reg_DoctorNote,
    AppInfo_Reg_DeptId,
    AppInfo_Reg_DeptName,
    AppInfo_Reg_PatientId,
    AppInfo_Reg_PatientName,
    AppInfo_Reg_PatientCard,
    AppInfo_Reg_TicketDate,
    AppInfo_Reg_TicketId,
    AppInfo_Reg_TicketFee,
    AppInfo_Reg_TicketRID,
    
    AppInfo_Patient_Intake,
    AppInfo_Patient_Default,
    AppInfo_Patient_List,
    AppInfo_Patient_Last,
    
    AppInfo_HospitalName,
    AppInfo_HospitalID,
    AppInfo_CurrentDepartmentName,
    AppInfo_CurrentDepartmentID,
    
    AppInfo_PlatformID,
    AppInfo_OrderHistory,
    
    AppInfo_NewVersion,
    AppInfo_FirstStart,
    
    AppInfo_MessageCache,
    AppInfo_CurrentCity,
    AppInfo_WexinOpenId,
    AppInfo_WexinUionid,
    AppInfo_WexinAccess_token,
    AppInfo_WexinNickname,
    AppInfo_WexinHeadimgurl,
    AppInfo_WexinSex,
    AppInfo_Zero
    
}





class HTTPClient: NSObject {
    
    override init() {
        super.init()
    }
    
    func  getHeader() ->(NSMutableDictionary? ){
        
        let header : NSMutableDictionary = [ "APIVER": APIVERSION,
            "APIVER": NSBundle.mainBundle().infoDictionary!["CFBundleVersion"]!,
            "package":NSBundle.mainBundle().bundleIdentifier!,
            "channel" : APICHANNEL,
            "os" : "ios"
        ]
        return header
    }
    
    
    
    
    func getParamsUrl( appUrl:AppUrl ) ->(NSMutableDictionary)?{
        
       // var urls_Info: NSMutableDictionary
        
        let urls_Info:NSMutableDictionary = [
            "\(AppUrl.AppURL_Setting)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Website)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_HomeInfo)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_SMSCode)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_BPush_Renew)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Login)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Logout)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Register)":["hid" : "0", "pid" : "0"]
            //========
            /*
            "\(AppUrl.AppURL_TicketRegister)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_GetTicket)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_ResetPwd)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_ResetPwd_SMS)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Departments)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Doctor_Recent)":["hid" : "0", "pid" : "0"],
            
            "\(AppUrl.AppURL_Doctor_Detail)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Doctor_ByDate)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Doctor_Search)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Doctor_FollowCheck)":["hid" : "0", "pid" : "1"],
            "\(AppUrl.AppURL_Doctor_FollowAdd)":["hid" : "0", "pid" : "1"],
            "\(AppUrl.AppURL_Doctor_FollowRemove)":["hid" : "0", "pid" : "1"],
            "\(AppUrl.AppURL_Doctor_FollowList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Hospital_Info)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Hospital_Config)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_PatientAdd)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_PatientRemove)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_PatientUpdate)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_PatientList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_PatientAutoCode)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_TicketList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_TicketDetail)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.APPURL_TicketCancel)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.APPURL_ScheduleDetail)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_MessageList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_MessageDetail)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_MessageDelete)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_AssayList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_AssayDetail)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_QueueList)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_HospitalList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Search_City)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_HospitalOnlineList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_HospitalTask)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Upgrade)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_ScheduleCalendar)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_SearchAll)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Search_Department)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Guide_Department)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Department_Inteligent)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Feedback_Add)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Information_Home)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Information_List)":["hid" : "0", "pid" : "1"],
            "\(AppUrl.AppURL_Information_DoctorList)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Information_MicroStation)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Message_Catalog)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Message_GetAll)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Website_Home)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Department_Website)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Website_HospitalHome)":["hid" : "1", "pid" : "0"],
            "\(AppUrl.AppURL_Website_ServiceList)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Information_Detail)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Website_HospitalDetail)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Website_DoctorList)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Assay_GetAll)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Pay_List)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Pay_Detail)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Hospital_TimeLine)":["hid" : "1", "pid" : "0"],
            "\(AppUrl.AppURL_Hospital_CheckRequire)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Patient_getHospital)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppInfo_Reg_OrderNO)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Pay_Check)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Pay_Waiting)":["hid" : "1", "pid" : "1"],
            "\(AppUrl.AppURL_Status_Read)":["hid" : "0", "pid" : "0"],
            "\(AppUrl.AppURL_Config_Get)":["hid" : "0", "pid" : "0"]
         */
        ]
     
        
        let dicUrl = urls_Info.objectForKey("\(appUrl)")
        var mutableDic :NSMutableDictionary = NSMutableDictionary()
        
        
        if (dicUrl != nil){
            if (dicUrl!.objectForKey("hid") as! NSString == "1" ){
                var  string : String = LibiaryAPI.shareInstance.getString("0") as! String;
                if (!string.isEmpty){
                  //mutableDic .setObject(LibiaryAPI.shareInstance.getString("\(AppInfoKey.AppInfo_HospitalID)"), forKey: "hid")
                }
            }
            if (dicUrl!.objectForKey("pid") as! NSString == "1" ){
                var  string : String = LibiaryAPI.shareInstance.getString("0") as! String;
                if (!string.isEmpty){
                   // mutableDic .setObject(LibiaryAPI.shareInstance.getString("\(AppInfoKey.AppInfo_PlatformID)"), forKey: "pid")
                }

            }

            
        }
        
        return  mutableDic
    }
    
    
    func Request( isPost:Bool  , appUrl :AppUrl ,  headInfoWithUserInfo :Bool,  params: [String : AnyObject]? , blockSucess : ((dicData:NSDictionary)-> Void) , failblock:((error:Error)->Void)){
        
        var header : NSMutableDictionary = NSMutableDictionary();
        header = self.getHeader()!
        
        //        var  header  = self.getHeader();
        
        if !isPlatformVersion{
            header .setObject(Platform, forKey: "Platform")
        }
        
        // let id =   AppInfoKey.AppInfo_BPush_UserID;
        if headInfoWithUserInfo{
            let userId = LibiaryAPI.shareInstance.getString("\(AppInfoKey.AppInfo_User_ID)")
            let userToken =  LibiaryAPI.shareInstance.getString("\(AppInfoKey.AppInfo_User_Token)")
            header .setObject(userId, forKey: "UID")
            header .setObject(userToken, forKey: "TOKEN")
            
        }
        if   isPlatformVersion{
            if (Platfrom_ID.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0){
                header .setObject(Platfrom_ID, forKey: "PID")
            }
        }
            
        else  if (!isPlatformVersion && !isSmallPlatformVersion){
            if (Platfrom_ID.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0){
                header .setObject(Platfrom_ID, forKey: "PID")
            }
            if (HOSPITAL_ID.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0){
                header .setObject(HOSPITAL_ID, forKey: "HID")
            }
            
        }
        
        var urlString =  self.stringHttpUrl(appUrl)
        let header1 = header as? [String: AnyObject]
        
        if isPost {
            Alamofire.request(.POST, urlString, parameters:header1 ).responseJSON {response in
                
                //            debugPrint(response)
                switch response.result {
                case .Success:
                    //把得到的JSON数据转为字典
                    if let j = response.result.value as? NSDictionary{
                        blockSucess(dicData: j);
                    }
                case .Failure(let error):
                    //                failblock(response.result.error)
                    print(error)
                }
            }
        } else{
            
            Alamofire.request(.GET, urlString, parameters:header1 ).responseJSON {response in
                
                //            debugPrint(response)
                switch response.result {
                case .Success:
                    //把得到的JSON数据转为字典
                   
                    if let j = response.result.value as? NSDictionary{
                     blockSucess( dicData: j);
                    }
                case .Failure(let error):
                    //                failblock(response.result.error)
//                    failblock(error:response.result.error)
                    print(error)
                }
            }
            
            
        }
        
        
    }
    
    func stringHttpUrl(appurl :AppUrl) -> String{
        
        var  strSuffix = ""
        switch appurl{
        case .AppURL_Setting:
            strSuffix = "setting/get"
            break
        case .AppURL_BPush_Renew:
            strSuffix = "user/flushToken"
            break
        case .AppURL_HomeInfo:
            strSuffix = "home/tips"
            break
            
        case .AppURL_Login:
            strSuffix = "user/login"
            break
            
        case .AppURL_Logout:
            strSuffix = "user/loginOut"
            break
            
        case .AppURL_Register:
            strSuffix = "user/reg"
            break
            
        case .AppURL_SMSCode:
            strSuffix = "user/regToken"
            break
            
        case .AppURL_ResetPwd_SMS:
            strSuffix = "user/getPwdToken"
            break
            
        case .AppURL_ResetPwd:
            strSuffix = "user/resetPwd"
            break
            
        case .AppURL_Guides:
            strSuffix = "guide/getAll"
            break
            
            
        case .AppURL_Departments:
            strSuffix = "department/getAll"
            break
            
        case .AppURL_Doctor_Recent:
            strSuffix = "schedule/getRecent"
            break
            
        case .AppURL_Doctor_Detail:
            strSuffix = "doctor/detail"
            break
            
        case .AppURL_Doctor_ByDate:
            strSuffix = "schedule/getDay"
            break
        case .AppURL_Doctor_Search:
            strSuffix = "search/depDoc"
            break
        case .AppURL_Doctor_FollowCheck:
            strSuffix = "follow/check"
            break
            
        case .AppURL_Doctor_FollowAdd:
            strSuffix = "follow/add"
            break
        case .AppURL_Doctor_FollowRemove:
            strSuffix = "follow/remove"
            break
        case .AppURL_Doctor_FollowList:
            strSuffix = "follow/getAll"
            break
        case .AppURL_Hospital_Info:
            strSuffix = "hospital/config"
            break
        case .AppURL_PatientAdd:
            strSuffix = "patient/add"
            break
        case .AppURL_PatientRemove:
            strSuffix = "patient/remove"
            break
        case .AppURL_PatientUpdate:
            strSuffix = "patient/update"
            break
        case .AppURL_PatientList:
            strSuffix = "patient/getList"
            break
            
        case .AppURL_PatientAutoCode:
            strSuffix = "patient/token"
            break
        case .AppURL_TicketRegister:
            strSuffix = "ticket/register"
            break
        case .AppURL_TicketList:
            strSuffix = "ticket/getall"
            break
            
        case .AppURL_TicketDetail:
            strSuffix = "ticket/detail"
            break
            
        case .APPURL_ScheduleDetail:
            strSuffix = "schedule/detail"
            break
        case .APPURL_TicketCancel:
            strSuffix = "ticket/cancel"
            break
        default:
            print("12312")
            
        }
        if (!strSuffix.isEmpty) {
            strSuffix = "\(PREFIX_URL)\(strSuffix)"
        }
        return strSuffix
        
    }

    
    
}


