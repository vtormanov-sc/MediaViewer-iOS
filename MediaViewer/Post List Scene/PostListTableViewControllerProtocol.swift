//
//  PostListTableViewControllerProtocol.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/21/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import UIKit

protocol PostListView: class, StateControllable {
    func didReceiveData()
    func reloadData()
    
    func goToWebView()
    func goToVideoView()
    
    func networkErrorOccured(description: String)
}
