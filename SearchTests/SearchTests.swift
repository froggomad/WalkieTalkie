//
//  SearchTests.swift
//  SearchTests
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import XCTest
@testable import WalkieTalkie

class SearchTests: XCTestCase {
    
    func testMatchingIncomingSearchReturnsResults() {
        let service = sut.service
        let recordings = sut.recordings
        
        XCTAssertEqual(service.search(for: .constant("john"), in: recordings, recordingType: .incoming), recordings)
        
        XCTAssertEqual(service.search(for: .constant("johna"), in: recordings, recordingType: .incoming), [recordings[1]])
    }
    
    func testMatchingOutgoingSearchReturnsResults() {
        let service = sut.service
        let recordings = sut.recordings
        
        XCTAssertEqual(service.search(for: .constant("paul"), in: recordings, recordingType: .outgoing), recordings)
        
        XCTAssertEqual(service.search(for: .constant("pau"), in: recordings, recordingType: .outgoing), recordings)
    }
    
    func testMismatchedSearchReturnsEmptyResults() {
        let service = sut.service
        let recordings = sut.recordings
        
        XCTAssertEqual(service.search(for: .constant("john"), in: recordings, recordingType: .outgoing), [])
        
        XCTAssertEqual(service.search(for: .constant("paul"), in: recordings, recordingType: .incoming), [])
    }
    
    var sut: (service: SearchService, recordings: [AudioRecording]) {
        (service: SearchService(),
         recordings: [
            AudioRecording(id: 0, usernameFrom: "John", usernameTo: "Paul", timestamp: Date(), recording: ""),
            AudioRecording(id: 0, usernameFrom: "Johnathan", usernameTo: "Paul", timestamp: Date(), recording: "")
         ])
    }
    
}
