//
//  HomeViewModel.swift
//  LiveTV
//
//  Created by Deabel on 2018/5/3.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

class HomeViewModel {
    lazy var anchorModels = [AnchorModel]()
}

extension HomeViewModel {
    func loadHomeData(type: HomeType, index: Int, finishedCallback: () -> ()) {
        let urlString = "http://qf.56.com/home/v4/moreAnchor.ios"
        let parameters = ["type" : type.type, "index" : index, "size" : 48]
        NetworkTool.requestData(.post, urlString: urlString, parameters: parameters) { (result) in
            print(result)
            guard let resultDict = result as? [String : Any] else { return }
            guard let messageDict = resultDict["message"] as? [String : Any] else { return }
            guard let anchorsArr = messageDict["anchors"] as? [String : Any] else { return }
            for dict in anchorsArr {
                let anchorModel = AnchorModel(dict: dict)
                self.anchorModels.append(anchorModel)
            }
//            for (index, dict) in anchorsArr.enumerated() {
//                let anchorModel = AnchorModel(dict: dict)
//                anchor.isEvenIndex = index % 2 == 0
//                self.anchorModels.append(anchorModel)
//            }
        }
    }
}
