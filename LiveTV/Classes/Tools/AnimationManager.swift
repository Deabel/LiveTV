
//
//  AnimationManager.swift
//  LiveTV
//
//  Created by Deabel on 2018/5/5.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

class AnimationManager {
    
    static let shareInstance = AnimationManager()
    fileprivate var granuleLayer: CAEmitterLayer!
}

// MARK: - 粒子动画图层的管理
extension AnimationManager {
    
    func addGranuleLayer(_ view: UIView, position: CGPoint) {
        // 创建发射器
        let emitter = CAEmitterLayer()
        granuleLayer = emitter
        emitter.position = position
        emitter.emitterSize = CGSize(width: 20, height: 20)
        emitter.renderMode = kCAEmitterLayerUnordered
        emitter.preservesDepth = true
        
        // 创建粒子
        var cells = [CAEmitterCell]()
        for i in 0..<10 {
            let cell = CAEmitterCell()
            cell.velocity = CGFloat(arc4random_uniform(100) + 100)
            cell.velocityRange = 80
            cell.scale = 0.7
            cell.velocityRange = 0.3
            cell.birthRate = 1
            cell.lifetime = Float(arc4random_uniform(4) + 1)
            cell.lifetimeRange = 1.5
            cell.emissionLongitude = CGFloat(-Double.pi/2)
            cell.emissionRange = CGFloat(Double.pi/2/6)
            cell.contents = UIImage(named: "good\(i)_30x30")?.cgImage
            cells.append(cell)
        }
        emitter.emitterCells = cells
        view.layer .addSublayer(emitter)
    }
    
    func removeGranuleLayer() {
        granuleLayer.removeFromSuperlayer()
    }
}
