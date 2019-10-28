//
//  LinkViewPresenter.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/22/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

class LinkViewPresenter {
    unowned var view: LinkView
    
    let selectedArticleUrl: URL!
    
    init(view: LinkView) {
        self.view = view
        self.selectedArticleUrl = SelectedArticleCache.retrieve()
    }
    
    func loadArticle() {
        let request = URLRequest(url: selectedArticleUrl)
        view.loadArticle(request)
    }
}
