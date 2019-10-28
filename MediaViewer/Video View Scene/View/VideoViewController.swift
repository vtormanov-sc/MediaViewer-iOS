//
//  VideoViewController.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/23/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import UIKit
import AVKit

class VideoViewController: AVPlayerViewController {
    
    var presenter: VideoViewPresenter!
    var selectedVideoUrl: URL!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = VideoViewPresenter(view: self)
        
        presenter.loadVideo()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        player?.removeObserver(self, forKeyPath: #keyPath(AVPlayer.currentItem.status))
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey: Any]?, context: UnsafeMutableRawPointer?) {
        if object is AVPlayer, keyPath == #keyPath(AVPlayer.currentItem.status) {
            let newStatus: AVPlayerItem.Status
            if let newStatusAsNumber = change?[NSKeyValueChangeKey.newKey] as? NSNumber {
                newStatus = AVPlayerItem.Status(rawValue: newStatusAsNumber.intValue) ?? .unknown
            } else {
                newStatus = .unknown
            }
            
            if newStatus == .failed {
                guard let description = self.player?.currentItem?.error?.localizedDescription else { return }
                
                presentNetworkErrorAlert(withDescription: description, dissmissOnOk: true)
            }
        }
    }
}

extension VideoViewController: VideoView {
    func loadVideo(withUrl url: URL) {
        let player = AVPlayer(url: url)
        
//        player.addObserver(self, forKeyPath: #keyPath(AVPlayer.status), options: [.new, .initial], context: nil)
        player.addObserver(self, forKeyPath: #keyPath(AVPlayer.currentItem.status), options:[.new, .initial], context: nil)
        
        self.player = player
        player.play()
    }
}
