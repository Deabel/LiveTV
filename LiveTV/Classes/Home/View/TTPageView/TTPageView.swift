//
//  TTPageView.swift
//  TTPageView
//
//  Created by Deabel on 2018/3/19.
//  Copyright © 2018年 Noerdenfit. All rights reserved.
//

import UIKit

class TTPageView: UIView {

    fileprivate var titles: [String]
    fileprivate var childVcs: [UIViewController]
    fileprivate var style: TTTitleStyle
    fileprivate var titleView: TTTitleView!
    fileprivate var parentVc: UIViewController
    fileprivate var contentView: TTContentView!
    
    init(frame: CGRect, titles: [String], childVcs: [UIViewController], parentVc: UIViewController, style: TTTitleStyle) {
        self.titles = titles
        self.childVcs = childVcs
        self.parentVc = parentVc
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 初始化UI
extension TTPageView {
    func setupUI() {
        
        setupTitleView()
        
        setupContentView()
    }
    
    // 初始化titleView
    func setupTitleView() {
        let titleViewFrame = CGRect(x: 0, y: 0, width: bounds.width, height: style.titleHeight)
        titleView = TTTitleView(frame: titleViewFrame, titles: titles, style: style)
        titleView.backgroundColor = UIColor.blue
        addSubview(titleView)
    }
    
    // 初始化ontentView
    func setupContentView() {
        let contentViewFrame = CGRect(x: 0, y: titleView.bounds.maxY, width: bounds.width, height: bounds.height - style.titleHeight)
        contentView = TTContentView(frame: contentViewFrame, childVcs: self.childVcs, parentVc: self.parentVc)
        contentView.backgroundColor = UIColor.orange
        titleView.delegate = contentView
        contentView.delegate = titleView
        addSubview(contentView)
    }
}
