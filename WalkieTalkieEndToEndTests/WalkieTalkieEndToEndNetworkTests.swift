//
//  WalkieTalkieEndToEndNetworkTests.swift
//  WalkieTalkieEndToEndNetworkTests
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import XCTest
@testable import WalkieTalkie

class WalkieTalkieEndToEndNetworkTests: XCTestCase {

    func testHistoryURL_completesData() {
        let request = GetRecordingRequest()
        let expectation = expectation(description: "testhistoryURL expectation")
        sut.processRequestable(with: request) { result in
            expectation.fulfill()
            switch result {
            case let .success(data):
                XCTAssertTrue(data.count > 0, "result should contain data, but it was empty")
            case let .failure(error):
                XCTFail("error returned: \(error)\n but should have received data")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    func testInvalidURL_completesError() {
        let request = InvalidRequestSpy()
        let expectation = expectation(description: "testinvalidURL expectation")
        sut.processRequestable(with: request) { result in
            expectation.fulfill()
            switch result {
            case .success:
                XCTFail("\(request.path) should have returned error, but returned data instead")
            case let .failure(error):
                XCTAssertEqual(error, .badRequest, "The request should've been invalid, but it wasn't")
            }
        }
        wait(for: [expectation], timeout: 10.0)
    }
    
    var sut: APIService {
        APIService()
    }
    
    class InvalidRequestSpy: Requestable {
        var path: String = "invalidPath"
        
        var requestType: RequestType = .GET
    }

}
