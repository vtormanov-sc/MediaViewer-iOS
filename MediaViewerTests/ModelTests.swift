//
//  ModelTests.swift
//  MediaViewerTests
//
//  Created by Gleb Shevchenko on 10/25/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import XCTest
@testable import MediaViewer

class ModelTests: XCTestCase {
    var sut: MockedArticleRepository!

    override func setUp() {
        super.setUp()
        
        sut = MockedArticleRepository()
    }

    override func tearDown() {
        sut = nil
        
        super.tearDown()
    }

    func testFilter() {
        let testList = DataList(entries: [
            MockedArticleRepository.getTestData(withTitle: "Avocado"),
            MockedArticleRepository.getTestData(withTitle: "Sandwich"),
            MockedArticleRepository.getTestData(withTitle: "Sauce"),
            MockedArticleRepository.getTestData(withTitle: "Pizza"),
            MockedArticleRepository.getTestData(withTitle: "Apple"),
            MockedArticleRepository.getTestData(withTitle: "Bagel")
        ])
        sut.writeData(testList)
        
        XCTAssertEqual(sut.filter(by: "A"), sut.filter(by: "a"))
        XCTAssertEqual(sut.filter(by: "a"), [
            MockedArticleRepository.getTestData(withTitle: "Avocado"),
            MockedArticleRepository.getTestData(withTitle: "Sandwich"),
            MockedArticleRepository.getTestData(withTitle: "Sauce"),
            MockedArticleRepository.getTestData(withTitle: "Pizza"),
            MockedArticleRepository.getTestData(withTitle: "Apple"),
            MockedArticleRepository.getTestData(withTitle: "Bagel")
        ])
        XCTAssertEqual(sut.filter(by: "b"), [
            MockedArticleRepository.getTestData(withTitle: "Bagel")
        ])
        XCTAssertEqual(sut.filter(by: "d"), [
            MockedArticleRepository.getTestData(withTitle: "Avocado"),
            MockedArticleRepository.getTestData(withTitle: "Sandwich")
        ])
    }
}
