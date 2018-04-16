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
//        navigationItem.titleView = searchBar
        let textField = searchBar.value(forKey: "_searchField") as! UITextField
        textField.textColor = UIColor.white
        
        // pageView
        let homeTypes = loadHomeTypes()
        let pageViewF = CGRect(x: 0, y: KNavgationH, width: KScreenW, height: KScreenH - KNavgationH)
        let titleArr = homeTypes.map({$0.title})
        var childVC = [AnchorViewController]()
        for i in 0..<titleArr.count {
            let vc = AnchorViewController()
            vc.homeType = homeTypes[i]
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
    
    fileprivate func loadHomeTypes() -> [HomeType] {
        let path = Bundle.main.path(forResource: "types.plist", ofType: nil)
        let types = NSArray(contentsOfFile: path!) as! [[String : Any]]
        var tempArray = [HomeType]()
        for type in types {
            let homeType = HomeType(newTitle: type["title"] as! String, newType: type["type"] as! Int)
            tempArray.append(homeType)
        }
        return tempArray
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
