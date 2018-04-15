//
//  TTTitleView.swift
//  TTPageView
//
//  Created by Deabel on 2018/3/19.
//  Copyright © 2018年 Noerdenfit. All rights reserved.
//

import UIKit

protocol TTTitleViewDelegate: class {
    func titleView(_ : TTTitleView, targetIndex: Int)
}

class TTTitleView: UIView {

    fileprivate var titles: [String]
    fileprivate var style: TTTitleStyle
    fileprivate lazy var bottomLineView: UIView = {
        let bottomLineView = UIView()
        bottomLineView.backgroundColor = self.style.bottomLineViewBGColor
        bottomLineView.frame.size.height = self.style.bottomLineViewHeight
        bottomLineView.frame.origin.y = self.scrollView.frame.height - self.style.bottomLineViewHeight - 2;
        return bottomLineView
    }()
    fileprivate lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView(frame: bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.backgroundColor = UIColor.groupTableViewBackground
        return scrollView
    }()
    fileprivate var currentLabel: UILabel!
    weak var delegate: TTTitleViewDelegate?
    
    init(frame: CGRect, titles: [String], style: TTTitleStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}


// MARK: - setup UI
extension TTTitleView {
    fileprivate func setupUI() {
        
        // 添加Scrollview
        addSubview(scrollView)
        
        // 添加标题
        var lastLaebl: UILabel = UILabel()
        for (i, title) in titles.enumerated() {
            let label = UILabel.init()
            label.text = title
            label.font = UIFont.systemFont(ofSize: style.fontSize)
            label.textColor = i == 0 ? style.selectColor : style.normalColor
            label.textAlignment = .center
            label.tag = i + 1
            label.sizeToFit()
            scrollView .addSubview(label)
            
            // 标题frame
            var x: CGFloat = 0, y: CGFloat = 0, w: CGFloat = 0, h: CGFloat = scrollView.bounds.height
            if style.scrollable {   // 标题栏可以滑动
                w = label.bounds.width
                x = lastLaebl.frame.maxX + (i == 0 ? style.titleMargin * 0.5 : style.titleMargin)
                
            } else {                // 标题栏不能滑动
                w = bounds.width / CGFloat(titles.count)
                x = CGFloat(i) * w;
            }
            
            label.frame = CGRect(x: x, y: y, width: w, height: h)
            lastLaebl = label;
            
            // 添加点击事件
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(tapActions(_:)))
            label.addGestureRecognizer(tapGesture)
            label.isUserInteractionEnabled = true
            currentLabel = i != 0 ? currentLabel : label
            
            // bottomLine的初始位置
            if i == 0 {
                bottomLineView.frame.size.width = label.frame.width
                bottomLineView.center.x = label.center.x
            }
        }
        
        let width = style.scrollable ? lastLaebl.frame.maxX + style.titleMargin * 0.5 : lastLaebl.frame.maxX
        scrollView.contentSize = CGSize(width: width, height: 0)
//        lastLaebl = nil   // lastLabel对象已无用，如何释放？
        
        // 添加bottomLineView
        scrollView.addSubview(bottomLineView)
    }
}


// MARK: - Actions
extension TTTitleView {
    @objc fileprivate func tapActions(_ tapGesture: UITapGestureRecognizer) {
        let targetLabel = tapGesture.view as! UILabel
        
        // 变换颜色
        for label in scrollView.subviews {
            if !label.isKind(of: UILabel.self) { continue }
            let label = label as! UILabel
            label.textColor = style.normalColor
        }
        targetLabel.textColor = style.selectColor
        
        // 选中标题居中
        var offsetX = targetLabel.center.x - bounds.width * 0.5
        if offsetX < 0 { offsetX = 0 }
        if offsetX > scrollView.contentSize.width - bounds.width { offsetX = scrollView.contentSize.width - bounds.width }
        scrollView.setContentOffset(CGPoint(x: offsetX, y: 0), animated: true)
        
        // 代理传值
        delegate?.titleView(self, targetIndex: targetLabel.tag - 1)
        
        // bottomLine
        self.bottomLineView.center.x = targetLabel.center.x
    }
}

// MARK: - 遵守代理/
extension TTTitleView: TTContentViewDelegate {
    func contentView(_: TTContentView, offsetX: CGFloat) {
        let currentIndex = Int(offsetX), rate = offsetX - CGFloat(currentIndex)
        let nextIndex = currentIndex + 1 > titles.count - 1 ? titles.count - 2 : currentIndex + 1
        let currentLabel = scrollView.subviews[currentIndex] as! UILabel
        let nextLabel = scrollView.subviews[nextIndex] as! UILabel
        
        // 颜色渐变 黑色 0, 0, 0   橘色 238, 136, 51
        currentLabel.textColor = UIColor.init(r: 238 * (1 - rate), g: 136 * (1 - rate), b: 51 * (1 - rate), alpha: 1)
        nextLabel.textColor = UIColor.init(r: 238 * rate, g: 136 * rate, b: 51 * rate, alpha: 1)
        
        // bottomLine
        let deltaCenterX = (nextLabel.center.x - currentLabel.center.x) * rate
        let deltaWidth = (nextLabel.frame.width - currentLabel.frame.width) * rate
        bottomLineView.center.x = currentLabel.center.x + deltaCenterX
        bottomLineView.frame.size.width = currentLabel.frame.width + deltaWidth
    }
    
    func contentViewDidEndDecelerating(_: TTContentView, offsetX: CGFloat) {
        // 选中标题居中
        let currentLabel = scrollView.subviews[Int(offsetX)] as! UILabel
        var offset = currentLabel.center.x - bounds.width * 0.5
        if offset < 0 { offset = 0 }
        if offset > scrollView.contentSize.width - bounds.width { offset = scrollView.contentSize.width - bounds.width }
        UIView.animate(withDuration: 0.25) {
            self.scrollView.setContentOffset(CGPoint(x: offset, y: 0), animated: false)
        }
    }
}
