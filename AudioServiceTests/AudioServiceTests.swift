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
        let url = Bundle.main.url(forResource: "example_recording", withExtension: "mp3")!
        let avPlayer = AudioService(persistenceService: .init(user: User(username: "admin", userType: .admin)))
        avPlayer.url = url
        avPlayer.player?.play()
        XCTAssertNil(avPlayer.player?.error)
        avPlayer.player?.pause()
    }
}
