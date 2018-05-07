//
//  KingfisherExtension.swift
//  LiveTV
//
//  Created by Deabel on 2018/5/4.
//  Copyright © 2018年 Manon. All rights reserved.
//

import Foundation
import Kingfisher

extension UIImageView {
    func setImage(urlString: String?, placeHoder: String? = nil) {
        guard let urlString = urlString else {
            return
        }
        
        guard let url = URL(string: urlString) else {
            return
        }
        
        guard let placeHoder = placeHoder else {
            kf.setImage(with: url)
            return
        }
        kf.setImage(with: url, placeholder: UIImage(named: placeHoder), options: nil, progressBlock: nil, completionHandler: nil)
    }
}
