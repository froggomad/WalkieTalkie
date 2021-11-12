//
//  AudioRecordingPersistenceTests.swift
//  AudioRecordingPersistenceTests
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import XCTest
@testable import WalkieTalkie

class AudioRecordingPersistenceTests: XCTestCase {

    override func tearDownWithError() throws {
        try super.tearDownWithError()
        sut.delete(AudioRecording.previewRecording, of: .outgoing)
        sut.delete(AudioRecording.previewRecording, of: .incoming)
    }

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

    func testLoadSavedRecording_returnsURL() {
        let recording = AudioRecording.previewRecording
        let recordingType: RecordingType = .outgoing
        let expectation = self.expectation(description: "wait for saving recording in testLoadSavedRecording_returnsURL")
        sut.save(recording, of: recordingType) { [weak self] _ in
            expectation.fulfill()
            guard let self = self else { return }
            let url = self.sut.load(recording, of: recordingType)
            XCTAssertNotNil(url)
            var components = url!.absoluteString.components(separatedBy: "/")
            components.removeLast() // remove empty position

            let previewRecordingURLFilename = AudioRecording.previewRecording.url.absoluteString
            let previewRecordingComponents = previewRecordingURLFilename.components(separatedBy: "/")

            XCTAssertEqual(components.last, previewRecordingComponents.last)
        }
        wait(for: [expectation], timeout: 10.0)
    }

    func testDeleteRecording_returnsTrue() {
        let expectation = self.expectation(description: "save file to test deleting recording")
        let recording = AudioRecording.previewRecording
        sut.save(recording, of: .outgoing) { [weak self] result in
            expectation.fulfill()
            guard let self = self else {
                XCTFail("self was nil in \(#function)")
                return
            }
            XCTAssertTrue(self.sut.delete(recording, of: .outgoing))
        }
        wait(for: [expectation], timeout: 10.0)
    }
}
