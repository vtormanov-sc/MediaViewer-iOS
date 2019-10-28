//
//  SelectedArticleCache.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/22/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

struct SelectedArticleCache {
    private enum Keys: String {
        case selectedArticleUrl = "selected_article_url"
    }
    
    static func cache(_ entry: Entry) {
        guard let url = URL(string: entry.link.href) else { return }
        
        UserDefaults.standard.set(url, forKey: Keys.selectedArticleUrl.rawValue)
    }
    
    static func retrieve() -> URL? {
        UserDefaults.standard.url(forKey: Keys.selectedArticleUrl.rawValue)
    }
}
