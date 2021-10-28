//
//  RecordingRow.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI
import AVKit

struct RecordingRow: View {
    @State var audioService = AudioService.shared
    @State var recording: AudioRecording
    
    var body: some View {
        VStack(alignment: .leading) {
            Text("From: \(recording.usernameFrom ?? "Anonymous")")
            VideoPlayer(player: audioService.player) {
                Color(.white)
            }
            .onDisappear() {
                audioService.player?.pause()
            }
            .frame(width: 75, height: 50, alignment: .bottom)
            .onTapGesture {
                audioService.url = recording.url
                audioService.player?.play()
            }
        }
        
    }
}

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordingRow(recording: AudioRecording.previewRecording)
    }
}
