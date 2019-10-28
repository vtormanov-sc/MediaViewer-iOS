//
//  Articles.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/21/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import Moya

public enum Articles {
    case jsonData
}

extension Articles: TargetType {
    public var baseURL: URL {
        switch self {
        case .jsonData:
            return URL(string: "https://www.dropbox.com/s/dl/bdcw3hpcj0fm90o")!
        }
    }
    
    public var path: String {
        switch self {
        case .jsonData:
            return "/sampleData.json"
        }
    }
    
    public var method: Moya.Method {
        switch self {
        case .jsonData:
            return .get
        }
    }
    
    public var sampleData: Data {
        switch self {
        case .jsonData:
            if let sampleDataPath = Bundle.main.path(forResource: "sampleData", ofType: "json"),
               let sampleData = FileManager.default.contents(atPath: sampleDataPath) {
                return sampleData
            } else {
                return Data()
            }
        }
    }
    
    public var task: Task {
        switch self {
        case .jsonData:
            return .requestPlain
        }
    }
    
    public var headers: [String : String]? {
        switch self {
        case .jsonData:
            return ["Content-Type": "application/json"]
        }
    }
}
