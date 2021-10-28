//
//  AudioService.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation
import AVFoundation

class AudioService {
    static let shared = AudioService()
    private init() {}
    
    var url: URL? {
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
    
    func playerLayer() -> AVPlayerLayer {
        return AVPlayerLayer(player: player)
    }
}

