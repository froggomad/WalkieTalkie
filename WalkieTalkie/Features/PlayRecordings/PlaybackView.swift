//
//  PlaybackView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import SwiftUI

struct PlaybackView: View {
    @State var recording: AudioRecording
    @State var audioService: AudioService
    
    var body: some View {
        ZStack {
            ColorSheet.primaryColor
                .ignoresSafeArea()
            VStack {
                HStack(alignment: .top) {
                    VStack(alignment: .leading) {
                        Text(recording.url.lastPathComponent)
                            .fontWeight(.semibold)
                            .accessibilityLabel("file name: \(recording.url.lastPathComponent)")
                        Text(recording.usernameFrom ?? "Anonymous")
                            .font(.callout)
                            .accessibilityLabel("from user \(recording.usernameFrom ?? "Anonymous")")
                    }
                    .foregroundColor(ColorSheet.lightText)
                    PlayButton(audioService: audioService, recording: recording)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 80)
                .onDisappear {
                    audioService.pause()
                }
                Spacer()
            }
        }
        .navigationTitle(Text(recording.timestamp, style: .date))
    }
}

struct PlaybackRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView(recording: .previewRecording, audioService: .init())
        
    }
}
