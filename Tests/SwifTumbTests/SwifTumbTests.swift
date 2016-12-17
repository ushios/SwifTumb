//
//  SwifTumbTests.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import XCTest
@testable import SwifTumb

class SwifTumbTests: XCTestCase {
    func testBaseUrl() {
        let url: String = SwifTumb.baseUrl()
        XCTAssertEqual(url, "https://api.tumblr.com/v2")
    }
    
    func testUrl() {
        let url: String = SwifTumb.url("test.json")
        XCTAssertEqual(url, "https://api.tumblr.com/v2/test.json")
    }


    static var allTests : [(String, (SwifTumbTests) -> () throws -> Void)] {
        return [
            ("testBaseUrl", testBaseUrl),
            ("testUrl", testUrl),
        ]
    }
}
