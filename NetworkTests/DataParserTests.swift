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
        let data =  AudioRecording.mockData
        let decodedData: [AudioRecording]? = try? sut.parse(data: data)
        XCTAssertNotNil(decodedData)
        XCTAssertEqual(decodedData?.count, 10)
    }
    
    func testDataParser_failsDecodingInvalidJSON() {
        let data =
        """
        recordings: [{ "id":1,"username_from":"farbrother0","timestamp":"1606314693","recording":"/recordings/example_transmission.mp3","username_to":"kyle_ski"
        }]
        """.data(using: .utf8)!
        let decodedData: [AudioRecording]? = try? sut.parse(data: data)
        XCTAssertNil(decodedData)
    }
    
    var sut: DataParser {
        DataParser()
    }

}
