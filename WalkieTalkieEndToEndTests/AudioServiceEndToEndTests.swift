//
//  AudioServiceEndToEndTests.swift
//  WalkieTalkieEndToEndTests
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import XCTest
@testable import WalkieTalkie

class AudioServiceEndToEndTests: XCTestCase {

    func testAudioServiceCanPlayURL() {
        let recording = AudioRecording.previewRecording
        let avPlayer = AudioService(persistenceService: .init(user: User(username: "admin", userType: .admin)))
        avPlayer.setRecording(recording, of: .outgoing)
        avPlayer.play()
        XCTAssertNil(avPlayer.player?.error)
        XCTAssertNotEqual(avPlayer.player?.status, .failed)
        avPlayer.player?.pause()
    }

}
