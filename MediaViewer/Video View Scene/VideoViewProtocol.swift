//
//  VideoViewProtocol.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/23/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

protocol VideoView: class {
    func loadVideo(withUrl url: URL)
}
