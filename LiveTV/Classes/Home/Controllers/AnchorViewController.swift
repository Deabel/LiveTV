//
//  AnchorViewController.swift
//  LiveTV
//
//  Created by Deabel on 2018/1/22.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

private let kEdgMargin: CGFloat = 8
private let cellID = "cellID"

class AnchorViewController: UIViewController {

    fileprivate lazy var collectionView: UICollectionView = {
        let layout = WaterFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: kEdgMargin, left: kEdgMargin, bottom: kEdgMargin, right: kEdgMargin)
        layout.minimumLineSpacing = kEdgMargin
        layout.minimumInteritemSpacing = kEdgMargin
        layout.dataSource = self
        
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.backgroundColor = UIColor.white
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        collectionView.register(UINib.init(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        return collectionView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addSubview(collectionView)
    }


}


extension AnchorViewController: UICollectionViewDelegate, UICollectionViewDataSource, WaterFlowLayoutDataSource {
    func waterFlowLayout(layout: WaterFlowLayout, indexPath: IndexPath) -> CGFloat {
//        print(indexPath.item, indexPath.row, indexPath.section)
        return indexPath.item % 2 == 0 ? KScreenW * 2 / 3 : KScreenW * 0.5
    }

    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 12;
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)

        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {

    }
}

