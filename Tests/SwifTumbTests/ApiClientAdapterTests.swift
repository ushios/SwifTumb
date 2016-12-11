//
//  SwifTumbTests.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/11.
//
//

import XCTest
@testable import SwifTumb

class OAuthSwiftAdapterTests: XCTestCase {
    func testBaseUrl() {
        let adapter = OAuthSwiftAdapter()
        XCTAssertEqual(adapter.baseUrl(), "api.tumblr.com/v2")
    }
    
    
    static var allTests : [(String, (OAuthSwiftAdapterTests) -> () throws -> Void)] {
        return [
            ("testExample", testBaseUrl),
        ]
    }
}
