//
//  AudioService.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation
import AVFoundation
import SwiftUI

class AudioService {
    @Published var isPaused: Bool = false
    var persistenceService: AudioRecordingPersistenceService

    init(persistenceService: AudioRecordingPersistenceService) {
        self.persistenceService = persistenceService
    }
    
    private var url: URL? {
        didSet {
            guard let url = url else { return }
            player = AVPlayer(url: url)
        }
    }
    
    var player: AVPlayer?
    
    func play() {
        player?.volume = 1.0
        player?.play()
    }

    func setRecording(_ recording: AudioRecording, of type: RecordingType) {
        if persistenceService.isRecordingSaved(recording, of: type) {
            url = persistenceService.load(recording, of: type)
        } else {
            url = recording.url
        }
    }
    
    func pause() {
        isPaused = true
        player?.pause()
    }
    
    func playerLayer() -> AVPlayerLayer {
        return AVPlayerLayer(player: player)
    }
}

