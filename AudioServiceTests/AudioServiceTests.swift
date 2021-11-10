//
//  AudioServiceTests.swift
//  AudioServiceTests
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import XCTest
@testable import WalkieTalkie

class AudioServiceTests: XCTestCase {
    func testAudioServiceCanPlayFile() {
        let avPlayer = AudioService(persistenceService: .init(user: User(username: "admin", userType: .admin)))
        avPlayer.setRecording(AudioRecording.previewRecording, of: .outgoing)
        avPlayer.player?.play()
        XCTAssertNil(avPlayer.player?.error)
        avPlayer.player?.pause()
    }
}
