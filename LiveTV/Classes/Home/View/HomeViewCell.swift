//
//  HomeViewCell.swift
//  LiveTV
//
//  Created by Deabel on 2018/1/22.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

class HomeViewCell: UICollectionViewCell {

    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleCount: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 5
        clipsToBounds = true
    }
    
}
