import XCTest
@testable import SwifTumbTests

XCTMain([
     testCase(SwifTumbTests.allTests),
     testCase(OAuthSwiftAdapterTests.allTests),
])
