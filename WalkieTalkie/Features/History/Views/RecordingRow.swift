//
//  RecordingRow.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI
import AVKit

struct RecordingRow: View, ToFromUser {
    @State var audioService: AudioService
    @State var recording: AudioRecording
    let recordingType: RecordingType
    
    var body: some View {
        HStack {
            let height: CGFloat = 35
            let width: CGFloat = (height * 0.6)
            
            Image(systemName: "mic.fill")
                .resizable()
                .frame(width: width, height: height)
                .foregroundColor(ColorSheet.actionColor)
            VStack(alignment: .leading) {
                Text(recording.url.lastPathComponent)
                    .font(.subheadline)
                    .accessibilityLabel("file name: \(recording.url.lastPathComponent)")
                Text("\(toFromLabel)\(toFromUsername)")
                    .font(.body)
                    .fontWeight(.semibold)
                    .accessibilityLabel("from user \(recording.unwrappedUsernameFrom)")
            }
        }
        
    }
}

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordingRow(audioService: MockAudioRecordingViewModel().audioService, recording: AudioRecording.previewRecording, recordingType: .outgoing)
    }
}
