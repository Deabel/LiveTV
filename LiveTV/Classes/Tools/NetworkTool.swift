//
//  NetworkTool.swift
//  LiveTV
//
//  Created by Deabel on 2018/5/3.
//  Copyright © 2018年 Manon. All rights reserved.
//

import Foundation
import Alamofire

enum MethodType {
    case get
    case post
}

class NetworkTool {
    class func requestData(_ type: MethodType, urlString: String, parameters: [String : Any]? = nil, finishedCallback:@escaping (_ result: Any) -> ()) {
        let method = type == .get ? HTTPMethod.get : HTTPMethod.post
        Alamofire.request(urlString, method: method, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            guard let result = response.result.value else {
                print("网络请求出错\(response.result.error!)")
                return;
            }
            finishedCallback(result)
        }
    }
}
