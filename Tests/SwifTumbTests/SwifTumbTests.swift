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
    var client: SwifTumb?
    
    override func setUp() {
        super.setUp()
        self.client = SwifTumb()
    }
    
    override func tearDown() {
        self.client = nil
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
        let handle = try! self.client!.userInfo(success: { (response: SwifTumbResponse) in
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
        let handle = try! self.client!.userDashboard(success: { (response: SwifTumbResponse) in
            XCTAssertEqual(200, response.meta.status, "user dashboard status")
            XCTAssertNotNil(response.response!.posts)
            responseExpectation.fulfill()
        }) { (error) in
            print(error)
        }
        XCTAssertNotNil(handle)
        
        self.waitForExpectations(timeout: 5, handler: nil)
    }
    
    func testUserLikes() {
        let responseExpectation = self.expectation(description: "get user likes")
        let handle = try! self.client!.userLikes(success: { (response: SwifTumbResponse) in
            XCTAssertEqual(200, response.meta.status, "user likes status")
            XCTAssertNotNil(response.response!.likedPosts)
            XCTAssertNotNil(response.response!.likedCount)
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
            ("testUserLikes", testUserLikes),
        ]
    }
}
