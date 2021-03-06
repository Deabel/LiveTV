//
//  TTFlowLayout.swift
//  TTFlowLayout
//
//  Created by Deabel on 2018/4/8.
//  Copyright © 2018年 Noerdenfit. All rights reserved.
//

import UIKit

class TTFlowLayout: UICollectionViewFlowLayout {

    fileprivate let column: NSInteger = 2   // 多少列
    fileprivate lazy var attributes = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var totalHeights: [CGFloat] = Array(repeating: self.sectionInset.top, count: self.column)
    fileprivate var maxH : CGFloat = 0
    fileprivate var startIndex = 0
    
    override func prepare() {
        super.prepare()
        
        // 每个cell都有UICollectionViewLayoutAttributes
        let cellCount = collectionView?.numberOfItems(inSection: 0)
        for i in startIndex..<cellCount! {
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 从最小高度开始排列
            let minH: CGFloat = totalHeights.min()!
            let minHIndex = totalHeights.index(of: minH)!
            
            // cell的frame
            var x: CGFloat = 0, y: CGFloat = 0, width: CGFloat = 0, height: CGFloat = 0
            width = (KScreenW - sectionInset.left - sectionInset.right - (CGFloat(column) - 1) * minimumInteritemSpacing) / CGFloat(column)
            height = CGFloat(arc4random() % 170 + 150)
            x = sectionInset.left + CGFloat(minHIndex) * (width + minimumInteritemSpacing)
            y = minH
            attr.frame = CGRect(x: x, y: y, width: width, height: height)
            attributes.append(attr)
            
            // cell的属性
            totalHeights[minHIndex] = minH + height + minimumLineSpacing
        }
        maxH = totalHeights.max()!
        startIndex = cellCount!
    }
}

// MARK: - 返回准备好的布局属性
extension TTFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attributes
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH)
    }
}
