//
//  AnchorViewController.swift
//  LiveTV
//
//  Created by Deabel on 2018/4/14.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

fileprivate let cellID = "CellID"
class AnchorViewController: UIViewController {

    var homeType: HomeType!
    
    fileprivate lazy var layout: TTFlowLayout = {
        let layout = TTFlowLayout()
        let margin: CGFloat = 10
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        return layout
    }()
    
    fileprivate lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: cellID)
//        collectionView.contentInset = UIEdgeInsetsMake(0, 0, KTabBarH, 0)
        return collectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
    }

}

// MARK: - Setup UI
extension AnchorViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK: - UICollectionView delegate
extension AnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIViewController()
        vc.view.backgroundColor = UIColor.white
        navigationController?.pushViewController(vc, animated: true)
    }
}
