//
//  OAuthSwiftAdapterTests.swift
//  SwifTumb
//
//  Created by Ushio Shugo on 2016/12/18.
//
//

import XCTest
import OAuthSwift
@testable import SwifTumb

class OAuthSwiftAdapterTests: XCTestCase {
    static let ConsumerKey: String = ""
    static let ConsumerSecret: String = ""
    static let OAuthToken: String = ""
    static let OAuthTokenSecret: String = ""
    
    
    var adapter: OAuthSwiftAdapter?
    
    override func setUp() {
        super.setUp()
        self.adapter = OAuthSwiftAdapter(
            consumerKey: OAuthSwiftAdapterTests.ConsumerKey,
            consumerSecret: OAuthSwiftAdapterTests.ConsumerSecret,
            oauthToken: OAuthSwiftAdapterTests.OAuthToken,
            oauthTokenSecret: OAuthSwiftAdapterTests.OAuthTokenSecret
        )
    }
    
    override func tearDown() {
        self.adapter = nil
        super.tearDown()
    }
    
    func testGetApi() {
        let responseExpectation = self.expectation(description: "get followings")
        
        let url: String = SwifTumb.url("user/info")
        let handle: OAuthSwiftRequestHandle? = self.adapter!.client.get(url, success: { (resp: OAuthSwiftResponse) in
            print(resp.dataString() ?? "")
            XCTAssertNotNil(resp.dataString())
            responseExpectation.fulfill()
        }) { (err: OAuthSwiftError) in
            XCTAssertNotNil(err)
        }
        XCTAssertNotNil(handle)
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    static var allTests : [(String, (OAuthSwiftAdapterTests) -> () throws -> Void)] {
        return [
            ("testGetApi", testGetApi),
        ]
    }
}
