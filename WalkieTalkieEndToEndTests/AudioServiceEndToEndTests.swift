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
        let url = URL(string: "localhost:3000/recordings/example_transmission.mp3")!
        let avPlayer = AudioService(persistenceService: .init(user: User(username: "admin", userType: .admin)))
        avPlayer.url = url
        avPlayer.play()
        XCTAssertNil(avPlayer.player?.error)
        XCTAssertNotEqual(avPlayer.player?.status, .failed)
        avPlayer.player?.pause()
    }

}
