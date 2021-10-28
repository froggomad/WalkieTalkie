//
//  RecordingRow.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI

struct RecordingRow: View {
    let recording: AudioRecording
    
    var body: some View {
        Text("From: \(recording.usernameFrom ?? "Anonymous")")
    }
}

struct RecordingRow_Previews: PreviewProvider {
    static var previews: some View {
        RecordingRow(recording: AudioRecording.previewRecording)
    }
}
