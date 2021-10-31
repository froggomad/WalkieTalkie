//
//  PlaybackView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import SwiftUI

struct PlaybackView: View {
    @State var recording: AudioRecording
    @Binding var audioService: AudioService
    
    var body: some View {
        VStack {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                    Text(recording.recording)
                        .fontWeight(.semibold)
                    Text(recording.usernameFrom ?? "")
                        .font(.callout)
                }
                PlayButton(audioService: audioService, recording: recording)
            }
            .padding(.horizontal, 20)
            .padding(.vertical, 80)
            .navigationTitle(Text(recording.timestamp, style: .date))
            .onDisappear {
                audioService.pause()
            }
            Spacer()
        }
    }
}

struct PlaybackRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView(recording: .previewRecording, audioService: .constant(.init()))
    }
}