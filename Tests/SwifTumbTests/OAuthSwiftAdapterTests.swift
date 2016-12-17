//
//  OAuthSwiftAdapterTests.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/18.
//
//

import XCTest
@testable import SwifTumb

class OAuthSwiftAdapterTests: XCTestCase {
    func testCreate() {
        let adapter: OAuthSwiftAdapter = OAuthSwiftAdapter(
            consumerKey: "",
            consumerSecret: ""
        )
        XCTAssertNotNil(adapter)
    }
    
    static var allTests : [(String, (OAuthSwiftAdapterTests) -> () throws -> Void)] {
        return [
            ("testCreate", testCreate),
        ]
    }
}
