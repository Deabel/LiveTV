//
//  XWTNavigationController.swift
//  LiveTV
//
//  Created by Manon on 2017/12/12.
//  Copyright © 2017年 Manon. All rights reserved.
//

import UIKit

class XWTNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        navigationBar.barTintColor = .black
        navigationBar.tintColor = UIColor.white
        navigationBar.titleTextAttributes = [NSAttributedStringKey.foregroundColor : UIColor.white]
        
        // 禁用系统手势
        interactivePopGestureRecognizer?.isEnabled = false
        
        // 自定义全屏pop手势
        let _target = (interactivePopGestureRecognizer!.value(forKey: "_targets") as! [NSObject])[0]
        let target = _target.value(forKey: "target")
        let tapGesture = UIPanGestureRecognizer(target: target!, action: Selector("handleNavigationTransition:"))
        view.addGestureRecognizer(tapGesture)
    }

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
