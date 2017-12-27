//
//  UIView-Frame.swift
//  LiveTV
//
//  Created by Manon on 2017/12/27.
//  Copyright © 2017年 Manon. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    var left: CGFloat
    {
        set { frame.origin.x = newValue }
        get { return frame.origin.x }
    }
    
    var top: CGFloat
    {
        set { frame.origin.y = newValue }
        get { return frame.origin.y }
    }
    
    var width: CGFloat
    {
        set { frame.size.width = newValue }
        get { return frame.size.width }
    }
    
    var height: CGFloat
    {
        set { frame.size.height = newValue }
        get { return frame.size.height }
    }
    
    var right: CGFloat
    {
        get { return frame.size.width + frame.origin.x }
    }
    
    var bottom: CGFloat
    {
        get { return frame.origin.y + frame.size.height }
    }
}
