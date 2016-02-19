//
//  HttpRequestClass.swift
//  project
//
//  Created by 于洋 on 16/1/5.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit

class HttpRequestClass: NSObject {
    static func stringHttpUrl(appurl :AppUrl) -> String{
        
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
        if strSuffix.lengthOfBytesUsingEncoding(NSUTF8StringEncoding) > 0 {
            strSuffix = "\(PREFIX_URL),\(strSuffix)"
        }
        return strSuffix
        
    }
}
