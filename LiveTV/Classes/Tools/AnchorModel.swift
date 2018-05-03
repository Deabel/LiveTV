
//
//  AnchorModel.swift
//  LiveTV
//
//  Created by Deabel on 2018/5/3.
//  Copyright © 2018年 Manon. All rights reserved.
//

import Foundation

class AnchorModel: BaseModel {
    @objc var uid : String = ""
    @objc var roomid : Int = 0
    @objc var name : String = ""
    @objc var pic51 : String = ""
    @objc var pic74 : String = ""
    @objc var live : Int = 0 // 是否在直播
    @objc var push : Int = 0 // 直播显示方式
    @objc var focus : Int = 0 // 关注数
    
    @objc var isEvenIndex : Bool = false
}
