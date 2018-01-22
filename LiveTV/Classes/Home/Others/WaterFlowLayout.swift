//
//  WaterFlowLayout.swift
//  LiveTV
//
//  Created by Deabel on 2018/1/22.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

@objc protocol WaterFlowLayoutDataSource : class {
    func waterFlowLayout(layout: WaterFlowLayout, indexPath: IndexPath) -> CGFloat
    @objc optional func numberOfColumnInWaterFlowLayout(layout: WaterFlowLayout) -> Int
}

class WaterFlowLayout: UICollectionViewFlowLayout {
    weak var dataSource : WaterFlowLayoutDataSource?
    
    fileprivate lazy var attrsArray: [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var columnHeights: [CGFloat] = {
        let column = self.dataSource?.numberOfColumnInWaterFlowLayout?(layout: self) ?? 2
        return Array(repeating: self.sectionInset.top, count: column)
    }()
    fileprivate var maxH: CGFloat = 0
    fileprivate var startIndex: Int = 0
}

extension WaterFlowLayout {
    override func prepare() {
        super.prepare()
        
        // item个数
        let itemCount = collectionView!.numberOfItems(inSection: 0)
        
        // 列数
        let column = dataSource?.numberOfColumnInWaterFlowLayout?(layout: self) ?? 2
        
        // item宽度
        let itemWidth = ((collectionView?.width)! - (sectionInset.left + minimumInteritemSpacing + sectionInset.right)) / CGFloat(column);
        
        // 创建所有item属性
        for i in startIndex..<itemCount {
            // 创建属性
            let indexPath = IndexPath(item: i, section: 0)
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            
            // 随机一个宽度
            guard let height = dataSource?.waterFlowLayout(layout: self, indexPath: indexPath) else {
                fatalError("请设置数据源，并实现相应方法")
            }
            
            var minH = columnHeights.min()
            let index = columnHeights.index(of: minH!)
            minH = minH! + minimumLineSpacing + height
            columnHeights[index!] = minH!
            
            // 更改item属性
            attr.frame = CGRect(x: sectionInset.left + (minimumInteritemSpacing + itemWidth) * CGFloat(index!),
                                y: minH! - height - minimumLineSpacing,
                                width: itemWidth,
                                height: height)
            attrsArray.append(attr)
            
            maxH = columnHeights.max()!
        }
    }
}

extension WaterFlowLayout {
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return attrsArray
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: 0, height: maxH + sectionInset.bottom)
    }
}
