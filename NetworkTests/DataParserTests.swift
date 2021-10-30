//
//  DataParserTests.swift
//  NetworkTests
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import XCTest
@testable import WalkieTalkie

class DataParserTests: XCTestCase {

    func testDataParser_canDecodeMockRecordings() {
        let parser = DataParser()
        let data =  AudioRecording.mockData
        let decodedData: [AudioRecording]? = try? parser.parse(data: data)
        XCTAssertNotNil(decodedData)
        XCTAssertEqual(decodedData?.count, 10)
    }

}
