//
//  NetworkTests.swift
//  NetworkTests
//
//  Created by Kenneth Dubroff on 10/29/21.
//

import XCTest
@testable import WalkieTalkie

class RequestableTests: XCTestCase {

    func testGetRecordingRequest_returnsHistoryURL() {
        let getHistoryRequest = GetRecordingRequest()
        let testRequest = try? getHistoryRequest.walkieTalkieURLRequest()
        XCTAssertEqual(testRequest?.url, URL(string: "http://localhost:3000/history"))
    }

}
