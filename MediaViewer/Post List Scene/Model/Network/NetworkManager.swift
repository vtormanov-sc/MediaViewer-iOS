//
//  NetworkManager.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/25/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import Moya

protocol NetworkManagerDelegate: class {
    func downloadFinished(receivedData: DataList?)
    func downloadFinishedWithError(error: MoyaError)
}

class NetworkManager {
    weak var delegate: NetworkManagerDelegate?
    private var provider = MoyaProvider<Articles>()
    
    func getArticles() {
        provider.request(.jsonData) { [weak self] result in
            switch result {
            case .success(let response):
                let list = try? response.map(DataList.self)
                
                self?.delegate?.downloadFinished(receivedData: list)
            case .failure(let error):
                self?.delegate?.downloadFinishedWithError(error: error)
            }
        }
    }
}
