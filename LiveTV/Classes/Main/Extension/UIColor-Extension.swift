
//
//  UIColor-Extension.swift
//  LiveTV
//
//  Created by Manon on 2017/12/12.
//  Copyright © 2017年 Manon. All rights reserved.
//

import UIKit

extension UIColor {
    // rgb颜色
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, alpha: CGFloat) {
        self.init(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: alpha)
    }
    
    // 十六进制颜色   0xff0000
    convenience init?(hex: String) {
        
        if hex.count > 8 {
            return nil
        }
        
        var red: Int32 = 0, greed: Int32 = 0, blue: Int32 = 0
        var range = NSMakeRange(2, 2)
        let redHex = (hex as NSString).substring(with: range)
        
        range.location += 2
        let greedHex = (hex as NSString).substring(with: range)
        
        range.location += 2
        let blueHex = (hex as NSString).substring(with: range)
        
        Scanner(string: redHex).scanInt32(&red)
        Scanner(string: greedHex).scanInt32(&greed)
        Scanner(string: blueHex).scanInt32(&blue)
        
        self.init(r: CGFloat(red), g: CGFloat(greed), b: CGFloat(blue), alpha: 1)
    }
    
    // 随机颜色
    class func randomColor() -> UIColor {
        return UIColor.init(r: CGFloat(arc4random_uniform(256)), g: CGFloat(arc4random_uniform(256)), b: CGFloat(arc4random_uniform(256)), alpha: 1.0)
    }
}


