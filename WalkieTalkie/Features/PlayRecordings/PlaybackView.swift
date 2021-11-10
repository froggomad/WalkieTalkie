//
//  PlaybackView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/30/21.
//

import SwiftUI

struct PlaybackView: View, ToFromUser {
    @State var recording: AudioRecording
    @State var viewModel: AudioRecordingViewModel

    let recordingType: RecordingType
    
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
                        Text("\(toFromLabel)\(toFromUsername)")
                            .font(.callout)
                            .accessibilityLabel("\(toFromLabel) user \(toFromUsername)")
                    }
                    .foregroundColor(ColorSheet.lightText)
                    PlayButton(audioService: viewModel.audioService, recording: recording, recordingType: recordingType)
                }
                .padding(.horizontal, 20)
                .padding(.vertical, 80)
                .onDisappear {
                    viewModel.audioService.pause()
                }

                SaveButton(persistenceService: viewModel.audioService.persistenceService, recording: recording, recordingType: recordingType)
                Spacer()
            }
        }
        .navigationTitle(Text(recording.timestamp, style: .date))
    }
}

struct PlaybackRecordingView_Previews: PreviewProvider {
    static var previews: some View {
        PlaybackView(recording: .previewRecording, viewModel: MockAudioRecordingViewModel(), recordingType: .outgoing)
    }
}
