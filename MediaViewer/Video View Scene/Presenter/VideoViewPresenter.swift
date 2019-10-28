//
//  VideoViewPresenter.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/23/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

class VideoViewPresenter {
    unowned var view: VideoView
    let selectedVideoUrl: URL!
    
    init(view: VideoView) {
        self.view = view
        selectedVideoUrl = SelectedArticleCache.retrieve()
    }
    
    func loadVideo() {
        view.loadVideo(withUrl: selectedVideoUrl)
    }
}
