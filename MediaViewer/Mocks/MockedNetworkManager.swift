//
//  MockedNetworkManager.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/25/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import Moya

class MockedNetworkManager {
    private var mockedProvider = MoyaProvider<Articles>(stubClosure: MoyaProvider.immediatelyStub)
    
    func getMockedArticles(completion: @escaping (DataList?) -> Void) {
        mockedProvider.request(.jsonData) { result in
            switch result {
            case .success(let response):
                let list = try? response.map(DataList.self)
                
                completion(list)
            case .failure:
                break
            }
        }
    }
}
