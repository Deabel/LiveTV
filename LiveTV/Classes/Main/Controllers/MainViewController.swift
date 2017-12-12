//
//  MainViewController.swift
//  LiveTV
//
//  Created by Manon on 2017/12/12.
//  Copyright © 2017年 Manon. All rights reserved.
//

import UIKit

class MainViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        addChildVC("Home")
        addChildVC("Rank")
        addChildVC("Discover")
        addChildVC("Mine")
        
        setTitleColor()
    }
    
    fileprivate func addChildVC(_ storyName: String) {
        let childVC = UIStoryboard(name: storyName, bundle: nil).instantiateInitialViewController()!
        addChildViewController(childVC)
    }
    
    fileprivate func setTitleColor() {
        let selectedColor = UIColor.init(r: 190, g: 139, b: 82, alpha: 1)
        let  normalColor = UIColor.init(white: 20/255.0, alpha: 1)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : normalColor], for: .normal)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor : selectedColor], for: .selected)
    }
}
