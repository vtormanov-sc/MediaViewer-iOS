//
//  NetworkModelTests.swift
//  NetworkModelTests
//
//  Created by Gleb Shevchenko on 10/25/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import XCTest
@testable import MediaViewer
import Moya

class NetworkModelTests: XCTestCase {
    var sut: MoyaProvider<Articles>!
    
    override func setUp() {
        super.setUp()
        sut = MoyaProvider<Articles>(stubClosure: MoyaProvider.immediatelyStub)
    }
    
    override func tearDown() {
        sut = nil
        super.tearDown()
    }
    
    func testSuccessfulParse() {
        // given
        var list: DataList?
        
        // when
        sut.request(.jsonData) { response in
            if case .success(let response) = response {
                list = try? response.map(DataList.self)
            }
        }
        
        // then
        XCTAssertNotNil(list)
    }
}

