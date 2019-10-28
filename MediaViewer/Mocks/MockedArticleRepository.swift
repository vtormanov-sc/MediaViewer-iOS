//
//  MockedArticleRepository.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/25/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

class MockedArticleRepository: ArticleRepository {    
    static func getTestData(withTitle title: String) -> Entry {
        Entry(type: EntryType(value: .link),
              title: title,
              summary: "",
              link: Link(href: ""),
              mediaGroup: [])
    }
}
