//
//  AudioServiceEndToEndTests.swift
//  WalkieTalkieEndToEndTests
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import XCTest
import AVFoundation

class AudioServiceEndToEndTests: XCTestCase {

    func testAudioServiceCanPlayURL() {
        let url = URL(string: "localhost:3000/recordings/example_transmission.mp3")!
        let avPlayer = AVPlayer(url: url)
        avPlayer.play()
        XCTAssertNil(avPlayer.error)
        XCTAssertNotEqual(avPlayer.status, .failed)
        avPlayer.pause()
    }

}
