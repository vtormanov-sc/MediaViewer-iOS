//
//  LinkViewProtocol.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/22/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

protocol LinkView: class, StateControllable {
    func loadArticle(_ request: URLRequest)
}
