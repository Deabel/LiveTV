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
    fileprivate let selectedColor = UIColor.init(r: 238, g: 136, b: 51 , alpha: 1)
    fileprivate let normalColor = UIColor.black
    open var controllerView: UIScrollView?
    
    init(frame: CGRect, titles: [String]) {
        super.init(frame: frame)
        
        titleArr = titles
        setupTitleView()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // 与控制器联动
    open func scrollViewDidScroll(offset: CGFloat) {
        print(offset, Int(offset))
        let index = Int(offset), nextIndex = index + 1, rate = offset - CGFloat(Int(offset))
        let button = scrollView?.subviews[index] as! UIButton ,
        nextBtn = index + 1 == titleArr.count ? UIButton() : scrollView?.subviews[nextIndex] as! UIButton
        
        // 重置按钮颜色
        for button in (scrollView?.subviews)! {
            if button.isKind(of: UIButton.self) {
                let btn = button as! UIButton
                btn.setTitleColor(normalColor, for: .normal)
            }
        }
        
        // 颜色 黑色 0, 0, 0   橘色 238, 136, 51
        let blackToOrange = UIColor.init(r: 238 * rate, g: 136 * rate, b: 51 * rate, alpha: 1)
        let orangeToBlack = UIColor.init(r: (1 - rate) * 238, g: (1 - rate) * 136, b: (1 - rate) * 51, alpha: 1)
        button.setTitleColor(orangeToBlack, for: .normal)
        nextBtn.setTitleColor(blackToOrange, for: .normal)
    }
    
    open func scrollViewDidEndDecelerating(offset: CGFloat) {
        // 偏移
        let button = scrollView?.subviews[Int(offset)] as! UIButton
        let maxOffset = (scrollView?.contentSize.width)! - KScreenW;
        var offset = button.center.x - KScreenW * 0.5;
        if offset > maxOffset { offset = maxOffset }
        if offset < 0 { offset = 0 }
        scrollView?.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
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
            titleBtn.setTitleColor(normalColor, for: .normal)
            titleBtn.sizeToFit()
            titleBtn.left = lastBtn.right + space
            titleBtn.center.y = (scrollView?.center.y)!
            titleBtn.setTitleColor(lastBtn.left == 0 ? selectedColor : normalColor, for: .normal)
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
        
        // titleView偏移
        let maxOffset = (scrollView?.contentSize.width)! - KScreenW;
        var offset = sender.center.x - KScreenW * 0.5;
        if offset > maxOffset { offset = maxOffset }
        if offset < 0 { offset = 0 }
        scrollView?.setContentOffset(CGPoint(x: offset, y: 0), animated: true)
        
        // controllerView偏移
        let subviews = scrollView?.subviews as! NSArray
        let point = CGPoint(x: CGFloat(subviews.index(of: sender)) * KScreenW, y: 0)
        controllerView?.setContentOffset(point, animated: false)
    }
}
