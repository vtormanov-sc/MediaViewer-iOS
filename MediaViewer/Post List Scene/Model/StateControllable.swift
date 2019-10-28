//
//  StateControllable.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/24/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation

enum ProgressState {
    case loading
    case ready
    case error
}

protocol StateControllable {
    var state: ProgressState { get set }
}
