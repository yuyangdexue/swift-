//
//  TabarModel.swift
//  project
//
//  Created by 于洋 on 16/1/6.
//  Copyright © 2016年 于洋. All rights reserved.
//

import UIKit
import ModelRocket


@objc(TabarModel)

class  TabarLastModel: Model ,JSONTransformable{
    let type = Property<String>(key: "type")
    let title     = Property<String>(key: "title")
    let image     = Property<String>(key: "image")
    let image_hl     = Property<String>(key: "image_hl")
}

class  TabarSubModel: Model,JSONTransformable {
     let title      = Property<String>(key: "title")
     let key     = Property<String>(key: "key")
     let image     = Property<String>(key: "image")
     let image_hl   = Property<String>(key: "image_hl")
     let  authen  = Property<Int>(key: "authen")
     let  disabled  = Property<Int>(key: "disabled")
     let  subitems=PropertyArray<TabarLastModel> (key: "subitems")
}

//@objc(TabarModel)
class TabarModel: Model {
    let   items = PropertyArray<TabarSubModel>(key: "items")
    
  
}



