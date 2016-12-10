import XCTest
@testable import SwifTumb

class SwifTumbTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(SwifTumb().text, "Hello, World!")
    }


    static var allTests : [(String, (SwifTumbTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
