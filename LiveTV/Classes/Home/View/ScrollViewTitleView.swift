//
//  ScrollViewTitleView.swift
//  LiveTV
//
//  Created by Manon on 2017/12/27.
//  Copyright © 2017年 Manon. All rights reserved.
//

import UIKit

class ScrollViewTitleView: UIView {

    fileprivate var scrollView: UIScrollView?
    fileprivate var titleArr: [String] = [String]()
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        
        titleArr = titles
        setupTitleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

// MARK: - 配置scrollView
extension ScrollViewTitleView {
    fileprivate func setupTitleView() {
        
        // scrollView
        scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: width, height: height))
        scrollView?.showsHorizontalScrollIndicator = false
        
        var lastBtn = UIButton()
        let space: CGFloat = 20.0
        for title in titleArr {
            let titleBtn = UIButton(type: .custom)
            titleBtn.setTitle(title, for: .normal)
            titleBtn.titleLabel?.font = UIFont.systemFont(ofSize: 15)
            titleBtn.setTitleColor(UIColor.black, for: .normal)
            titleBtn.setTitleColor(UIColor.init(r: 238, g: 136, b: 51, alpha: 1), for: .selected)
            titleBtn.sizeToFit()
            titleBtn.left = lastBtn.right + space
            titleBtn.center.y = (scrollView?.center.y)!
            titleBtn.isSelected = lastBtn.left == 0 ? true : false;
            titleBtn.addTarget(self, action: #selector(titleClick), for: .touchUpInside)
            scrollView?.addSubview(titleBtn)
            lastBtn = titleBtn
        }
        scrollView?.contentSize = CGSize(width: lastBtn.right + space, height: 0)
        addSubview(scrollView!)
        
        // lineView
        let lineView = UIView(frame: CGRect(x: 0, y: (scrollView?.bottom)! - 1, width: width, height: 1))
        lineView.backgroundColor = UIColor.groupTableViewBackground
        addSubview(lineView)
    }
}

// MARK: - 事件处理
extension ScrollViewTitleView {
    @objc fileprivate func titleClick(sender: UIButton) {
        
        // 标题颜色
        for button in (scrollView?.subviews)! {
            if button.isKind(of: UIButton.self) {
                let btn = button as! UIButton
                btn.isSelected = false
            }
        }
        sender.isSelected = true
        
        // 自动偏移
        let maxOffset = (scrollView?.contentSize.width)! - KScreenW;
        var offset = sender.center.x - KScreenW * 0.5;
        if offset > maxOffset { offset = maxOffset }
        if offset < 0 { offset = 0 }
        scrollView?.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
    }
}
