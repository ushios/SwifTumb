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
    var adapter: OAuthSwiftAdapter?
    
    override func setUp() {
        super.setUp()
        
        guard let consumerKey = getenv(SwifTumb.EnvConsumerKey),
            let consumerSecret = getenv(SwifTumb.EnvConsumerSecret),
            let oauthToken = getenv(SwifTumb.EnvOAuthToken),
            let oauthTokenSecret = getenv(SwifTumb.EnvOAuthTokenSecret)
            else {
                return
        }
        
        self.adapter = OAuthSwiftAdapter(
            consumerKey: String(utf8String: consumerKey) ?? "",
            consumerSecret: String(utf8String: consumerSecret) ?? "",
            oauthToken: String(utf8String: oauthToken) ?? "",
            oauthTokenSecret: String(utf8String: oauthTokenSecret) ?? ""
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
            XCTAssertNotNil(resp.dataString())
            responseExpectation.fulfill()
        }) { (err: OAuthSwiftError) in
            XCTAssertNil(err)
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
