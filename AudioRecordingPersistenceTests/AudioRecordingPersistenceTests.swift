//
//  AudioRecordingPersistenceTests.swift
//  AudioRecordingPersistenceTests
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import XCTest
@testable import WalkieTalkie

class AudioRecordingPersistenceTests: XCTestCase {
    private var sut: AudioRecordingPersistenceService = .init(user: User(username: "admin", userType: .admin))

    func testSaveRecordingToDisk_returnsTrue() {
        let expectation = self.expectation(description: "test saving recording")
        sut.save(AudioRecording.previewRecording, of: .outgoing) { [weak self] result in
            guard let self = self else {
                return
            }

            switch result {
            case let .failure(error):
                XCTFail("Error received while saving file: \(error.localizedDescription)")
            case let .success(result):
                XCTAssertTrue(result)
                XCTAssertTrue(self.sut.isRecordingSaved(AudioRecording.previewRecording, of: .outgoing))
            }
            expectation.fulfill()
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
