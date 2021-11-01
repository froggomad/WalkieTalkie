//
//  RecordingRow.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI
import AVKit

struct RecordingRow: View {
    @State var audioService: AudioService
    @State var recording: AudioRecording
    
    var body: some View {
        HStack {
            let height: CGFloat = 35
            let width: CGFloat = (height * 0.6)
            
            Image(systemName: "mic.fill")
                .resizable()
                .frame(width: width, height: height)
                .foregroundColor(ColorSheet.actionColor)
            VStack(alignment: .leading) {
                Text(recording.recording)
                    .font(.subheadline)
                    .accessibilityLabel("file name: \(recording.recording)")
                Text("From: \(recording.usernameFrom ?? "Anonymous")")
                    .font(.body)
                    .fontWeight(.semibold)
                    .accessibilityLabel("from user \(recording.usernameFrom ?? "Anonymous")")
            }
        }
        
    }
}

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordingRow(audioService: AudioService(), recording: AudioRecording.previewRecording)
    }
}
