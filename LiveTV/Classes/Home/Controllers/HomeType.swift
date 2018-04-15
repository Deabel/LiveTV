//
//  HomeType.swift
//  LiveTV
//
//  Created by Deabel on 2018/4/14.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

class HomeType: BaseModel {
    var title : String = ""
    var type : Int = 0
    
    init(newTitle: String, newType: Int) {
        super.init()
        
        title = newTitle
        type = newType
    }
}
