//
//  AnchorViewController.swift
//  LiveTV
//
//  Created by Deabel on 2018/4/14.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

fileprivate let cellID = "homeViewCell"
class AnchorViewController: UIViewController {

    var homeType: HomeType!
    fileprivate var homeViewModel = HomeViewModel()
    
    fileprivate lazy var layout: TTFlowLayout = {
        let layout = TTFlowLayout()
        let margin: CGFloat = 10
        layout.sectionInset = UIEdgeInsetsMake(margin, margin, margin, margin)
        layout.minimumLineSpacing = margin
        layout.minimumInteritemSpacing = margin
        return layout
    }()
    
    lazy var collectionView: UICollectionView = {
        let collectionView = UICollectionView(frame: view.bounds, collectionViewLayout: layout)
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(UINib(nibName: "HomeViewCell", bundle: nil), forCellWithReuseIdentifier: cellID)
        collectionView.backgroundColor = UIColor.randomColor()
        collectionView.contentInset = UIEdgeInsetsMake(0, 0, KTabBarH, 0)
        collectionView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        return collectionView;
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadData(index: 0)
    }
}

// MARK: - Setup UI
extension AnchorViewController {
    func setupUI() {
        view.addSubview(collectionView)
    }
}

// MARK: - LoadData
extension AnchorViewController {
    func loadData(index: Int) {
        homeViewModel.loadHomeData(type: homeType, index: index) {
            collectionView.reloadData()
        }
    }
}

// MARK: - UICollectionView delegate
extension AnchorViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return homeViewModel.anchorModels.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! HomeViewCell
        let anchorModel = homeViewModel.anchorModels[indexPath.item]
        print(anchorModel)
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let vc = UIViewController()
        navigationController?.pushViewController(vc, animated: true)
    }
}
