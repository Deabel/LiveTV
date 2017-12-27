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
    fileprivate var titleView: ScrollViewTitleView?
    fileprivate var controllerView: UIScrollView?
    
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
        
        // 滚动标题
        let titleArr = ["全部", "高颜值", "偶像派", "好声音", "好才艺", "小鲜肉", "搞笑", "劲爆", "还有更多"]
        titleView = ScrollViewTitleView(frame: CGRect.init(x: 0, y: KNavgationH, width:KScreenW , height: 40),
                                            titles:titleArr)
        view.addSubview(titleView!)
        
        // 控制器
        controllerView = UIScrollView(frame: CGRect(x: 0, y: (titleView?.bottom)!, width: KScreenW, height: KScreenH - (titleView?.bottom)!))
        controllerView?.isPagingEnabled = true
        controllerView?.showsHorizontalScrollIndicator = false
        controllerView?.contentSize = CGSize(width: KScreenW * CGFloat(titleArr.count), height: 0)
        controllerView?.delegate = self
        view.addSubview(controllerView!)
        
        for i in 0..<titleArr.count {
            let vc = UIViewController()
            vc.view.frame = CGRect(x: KScreenW * CGFloat(i), y: 0, width: KScreenW, height: (controllerView?.height)!)
            vc.view.backgroundColor = UIColor.randomColor()
            controllerView?.addSubview(vc.view)
        }
    }
    
    // 添加titleView导致导航栏+状态栏高度为100，此为应急处理
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        titleView?.top = (navigationController?.navigationBar.bottom)!
        controllerView?.top = (titleView?.bottom)!
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

// MARK: - scrollView delegate
extension HomeViewController : UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        titleView?.autoScrollTitleView(offset: scrollView.contentOffset.x/KScreenW)
    }
}
