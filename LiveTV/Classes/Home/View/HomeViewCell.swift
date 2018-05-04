//
//  HomeViewCell.swift
//  LiveTV
//
//  Created by Deabel on 2018/1/22.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit
import Kingfisher

class HomeViewCell: UICollectionViewCell {
    
    @IBOutlet weak var albumImageView: UIImageView!
    @IBOutlet weak var liveImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var onlinePeopleCount: UIButton!
    
    var anchorModel: AnchorModel! {
        didSet {
            albumImageView.setImage(urlString: anchorModel.isEvenIndex ? anchorModel.pic74 : anchorModel.pic51, placeHoder: "home_pic_default")
            liveImageView.isHidden = anchorModel.live == 0
            nickNameLabel.text = anchorModel.name
            onlinePeopleCount.setTitle("\(anchorModel.focus)", for: .normal)
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        layer.cornerRadius = 5
        mask?.clipsToBounds = true
    }
}
