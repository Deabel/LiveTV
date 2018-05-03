//
//  TTContentView.swift
//  TTPageView
//
//  Created by Deabel on 2018/3/19.
//  Copyright © 2018年 Noerdenfit. All rights reserved.
//

import UIKit

protocol TTContentViewDelegate: class {
    func contentView(_: TTContentView, offsetX: CGFloat)
//    func contentView(_: TTContentView, currentIndex: Int, targetIndex: Int, progress: CGFloat)
    func contentViewDidEndDecelerating(_: TTContentView, offsetX: CGFloat)
}

fileprivate let cellID = "cellID"
class TTContentView: UIView {

    fileprivate var childVcs: [UIViewController]
    fileprivate var parentVc: UIViewController
    weak var delegate: TTContentViewDelegate?
    fileprivate lazy var collectionView: UICollectionView = {
       let layout = UICollectionViewFlowLayout()
        layout.itemSize = self.bounds.size
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let collectionViewFrame = self.bounds
        let collectionView = UICollectionView(frame: collectionViewFrame, collectionViewLayout: layout)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
        collectionView.isPagingEnabled = true
        collectionView.bounces = false
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.backgroundColor = UIColor.red
//        collectionView.contentInset = UIEdgeInsetsMake(0, 0, KTabBarH, 0)
        return collectionView
    }()
    
    init(frame: CGRect, childVcs: [UIViewController], parentVc: UIViewController) {
        self.childVcs = childVcs
        self.parentVc = parentVc
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: - 布局UI
extension TTContentView {
    func setupUI() {
        addSubview(collectionView)
        
        for childVc in childVcs {
            parentVc.addChildViewController(childVc)
        }
    }
}

// MRAK: - collectionView delegate
extension TTContentView : UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        
        let childVc = childVcs[indexPath.item] as! AnchorViewController
        childVc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVc.view)
        
        return cell
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
//        print(scrollView.contentOffset.x/bounds.width)
        let offsetX = scrollView.contentOffset.x/bounds.width
        delegate?.contentView(self, offsetX: offsetX)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        delegate?.contentViewDidEndDecelerating(self, offsetX: scrollView.contentOffset.x/bounds.width)
    }
}

// MARK: - TTTitleViewDelegate
extension TTContentView: TTTitleViewDelegate {
    func titleView(_: TTTitleView, targetIndex: Int) {
        let indexPath = IndexPath(item: targetIndex, section: 0)
        collectionView.scrollToItem(at: indexPath, at: .left, animated: false)
    }
}
