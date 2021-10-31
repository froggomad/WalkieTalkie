//
//  PlayButton.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import SwiftUI

struct PlayButton: View {
    @State var audioService: AudioService
    @State var recording: AudioRecording
    @State var isPlaying: Bool = false
    
    var body: some View {
        if !isPlaying {
            Button {
                audioService.url = recording.url
                audioService.play()
                isPlaying = true
            } label: {
                Image(systemName: "play.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
            }
        } else {
            Button {
                audioService.pause()
                isPlaying = false
            } label: {
                Image(systemName: "pause.circle.fill")
                    .resizable()
                    .frame(width: 50, height: 50, alignment: .center)
            }
        }
    }
}

struct PlayButton_Previews: PreviewProvider {
    static var previews: some View {
        PlayButton(audioService: .init(), recording: .previewRecording, isPlaying: false)
    }
}