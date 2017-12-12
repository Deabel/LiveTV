//
//  HomeViewController.swift
//  LiveTV
//
//  Created by Manon on 2017/12/12.
//  Copyright © 2017年 Manon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        setupUI()
        
    }
}

// MARK: - 设置UI
extension HomeViewController {
    fileprivate func setupUI() {
        
        // 导航栏
        navigationItem.leftBarButtonItem = UIBarButtonItem(image: UIImage(named: "home-logo"), style: .plain, target: self, action: #selector(leftButtonClick))
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(named: "search_btn_follow"), style: .plain, target: self, action: #selector(rightButtonClick))
        
        // 搜索框
        let searchBar = UISearchBar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 32)))
        searchBar.text = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        searchBar.showsCancelButton = false
        navigationItem.titleView = searchBar
        let textField = searchBar.value(forKey: "_searchField") as! UITextField
        textField.textColor = UIColor.white
    }
}

// MARK: - 处理事件
extension HomeViewController {
    @objc fileprivate func leftButtonClick() {
        
    }
    
    @objc fileprivate func rightButtonClick() {
    
    }
}
