//
//  RoomViewController.swift
//  LiveTV
//
//  Created by Deabel on 2018/5/5.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit

class RoomViewController: UIViewController {

    
    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNumLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(false, animated: true)
    }

    
    
}

// MARK: - Actions
extension RoomViewController {
    @IBAction func focusBtnClick(_ sender: UIButton) {
        
    }
    
    @IBAction func chatItemClick(_ sender: UIButton) {
    }
    
    @IBAction func shareItemClick(_ sender: UIButton) {
    }
    
    @IBAction func giftItemClick(_ sender: UIButton) {
    }
    
    @IBAction func moreItemClick(_ sender: UIButton) {
    }
    
    @IBAction func starItemClick(_ sender: UIButton) {
        sender.isSelected = !sender.isSelected
        sender.isSelected ? AnimationManager.shareInstance.addGranuleLayer(view, position: CGPoint(x: sender.center.x, y: KScreenH - sender.width * 0.5)) :
        AnimationManager.shareInstance.removeGranuleLayer()
    }
    
    @IBAction func closeBntClick(_ sender: UIButton) {
    }
}
