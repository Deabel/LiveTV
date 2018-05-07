//
//  RoomViewController.swift
//  LiveTV
//
//  Created by Deabel on 2018/5/5.
//  Copyright © 2018年 Manon. All rights reserved.
//

import UIKit
//import IJKMediaFramework

class RoomViewController: UIViewController {

    @IBOutlet weak var iconImageView: UIImageView!
    @IBOutlet weak var bgImageView: UIImageView!
    @IBOutlet weak var nickNameLabel: UILabel!
    @IBOutlet weak var roomNumLabel: UILabel!
    @IBOutlet weak var onlineLabel: UILabel!
    
    var anchorModel: AnchorModel!
    fileprivate var viewModel = RoomViewModel()
    fileprivate var player: IJKFFMoviePlayerController?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        
        loadRoomInfo()
        
        (navigationController as! XWTNavigationController).customGestureEnable = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player?.stop()
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
}

// MARK: - Setup UI
extension RoomViewController {
    fileprivate func setupUI() {
        setupBlurView()
        
        setupInfo()
    }
    
    fileprivate func setupBlurView() {
        let style = UIBlurEffect(style: .dark)
        let blurView = UIVisualEffectView(effect: style)
        blurView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
        blurView.frame = bgImageView.bounds
        bgImageView.addSubview(blurView)
    }
    
    fileprivate func setupInfo() {
        bgImageView.setImage(urlString: anchorModel.pic74)
        iconImageView.setImage(urlString: anchorModel.pic51)
        nickNameLabel.text = anchorModel.name
        roomNumLabel.text = "\(anchorModel.roomid)"
        onlineLabel.text = "\(anchorModel.focus)"
    }
}

// MARK: - 加载直播信息
extension RoomViewController {
    fileprivate func loadRoomInfo() {
        if let roomId = anchorModel?.roomid, let uid = anchorModel?.uid {
            viewModel.loadLiveURL(roomId, uid) {
                self.setupDisplayView()
            }
        }
    }
    
    fileprivate func setupDisplayView() {
        IJKFFMoviePlayerController.setLogReport(false)
        let liveUrl = URL(string: self.viewModel.liveURL)
        print("live地址:\(liveUrl!)")
        player = IJKFFMoviePlayerController(contentURL: liveUrl!, with: nil)
        if anchorModel?.push == 1 {
            let screenW = UIScreen.main.bounds.width
            player?.view.frame = CGRect(x: 0, y: 0, width: screenW, height: screenW * 3 / 4)
            player?.view.center = view.center
        } else {
            player?.view.frame = view.bounds
        }
        bgImageView.insertSubview(player!.view, at: 1)
        
        // 准备播放
        DispatchQueue.global().async {
            self.player?.prepareToPlay()
            self.player?.play()
        }
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
        navigationController?.popViewController(animated: true)
    }
}
