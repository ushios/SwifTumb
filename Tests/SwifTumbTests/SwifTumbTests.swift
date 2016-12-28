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
    static let ConsumerKey: String = ""
    static let ConsumerSecret: String = ""
    static let OAuthToken: String = ""
    static let OAuthTokenSecret: String = ""
    
    var adapter: OAuthSwiftAdapter?
    
    override func setUp() {
        super.setUp()
        self.adapter = OAuthSwiftAdapter(
            consumerKey: SwifTumbTests.ConsumerKey,
            consumerSecret: SwifTumbTests.ConsumerSecret,
            oauthToken: SwifTumbTests.OAuthToken,
            oauthTokenSecret: SwifTumbTests.OAuthTokenSecret
        )
    }
    
    override func tearDown() {
        self.adapter = nil
        super.tearDown()
    }
    
    func testBaseUrl() {
        let url: String = SwifTumb.baseUrl()
        XCTAssertEqual(url, "https://api.tumblr.com/v2")
    }
    
    func testUrl() {
        let url: String = SwifTumb.url("test.json")
        XCTAssertEqual(url, "https://api.tumblr.com/v2/test.json")
    }
    
    func testUserInfo() {
        let responseExpectation = self.expectation(description: "get user info")
        let client: SwifTumb = SwifTumb(adapter: self.adapter!)
        
        let handle = try! client.userInfo(success: { (response: SwifTumbResponse) in
            XCTAssertEqual(200, response.meta.status, "user info status")
            XCTAssertNotNil(response.response!.user)
            responseExpectation.fulfill()
        }) { (error) in
            print(error)
        }
        XCTAssertNotNil(handle)
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserDashboard() {
        let responseExpectation = self.expectation(description: "get user dashboard")
        let client: SwifTumb = SwifTumb(adapter: self.adapter!)
        
        let handle = try! client.userDashboard(success: { (response: SwifTumbResponse) in
            XCTAssertEqual(200, response.meta.status, "user dashboard status")
            XCTAssertNotNil(response.response!.posts)
            responseExpectation.fulfill()
        }) { (error) in
            print(error)
        }
        XCTAssertNotNil(handle)
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }


    static var allTests : [(String, (SwifTumbTests) -> () throws -> Void)] {
        return [
            ("testBaseUrl", testBaseUrl),
            ("testUrl", testUrl),
            ("testUserInfo", testUserInfo),
            ("testUserDashboard", testUserDashboard),
        ]
    }
}
