//
//  HomeViewController.swift
//  LiveTV
//
//  Created by Manon on 2017/12/12.
//  Copyright © 2017年 Manon. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController {

    fileprivate var searchBar: UISearchBar = UISearchBar()
    fileprivate var pageView: TTPageView!
    fileprivate var style: TTTitleStyle = TTTitleStyle()
    
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
        searchBar = UISearchBar(frame: CGRect(origin: CGPoint.zero, size: CGSize(width: 300, height: 20)))
        searchBar.placeholder = "主播昵称/房间号/链接"
        searchBar.searchBarStyle = .minimal
        searchBar.isTranslucent = true
        navigationItem.titleView = searchBar
        let textField = searchBar.value(forKey: "_searchField") as! UITextField
        textField.textColor = UIColor.white
        
        // pageView
        let pageViewF = CGRect(x: 0, y: KNavgationH, width: KScreenW, height: KScreenH - KNavgationH)
        let titleArr = ["全部", "高颜值", "偶像派", "好声音", "好才艺", "小鲜肉", "搞笑", "劲爆", "还有更多"]
        var childVC = [AnchorViewController]()
        for _ in titleArr {
            let vc = AnchorViewController()
            vc.view.backgroundColor = UIColor.randomColor()
            childVC.append(vc)
        }
        pageView = TTPageView(frame: pageViewF, titles: titleArr, childVcs: childVC, parentVc: self, style: style)
        view.addSubview(pageView)
    }
    
    // 添加titleView导致导航栏+状态栏高度为100，此为应急处理
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)

        pageView?.top = (navigationController?.navigationBar.bottom)!
    }
}

// MARK: - 处理事件
extension HomeViewController {
    @objc fileprivate func leftButtonClick() {
        
    }
    
    @objc fileprivate func rightButtonClick() {
    
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        searchBar.endEditing(true)
    }
}
