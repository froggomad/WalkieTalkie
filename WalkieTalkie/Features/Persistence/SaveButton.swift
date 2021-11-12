//
//  SaveButton.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import SwiftUI


struct SaveButton: View {
    var persistenceService: AudioRecordingPersistenceService
    @State var isRecordingSaved: Bool = false

    var recording: AudioRecording
    var recordingType: RecordingType

    var body: some View {
        VStack {
            if !isRecordingSaved {
                Button("Save Recording") {
                    persistenceService.save(recording, of: recordingType) { result in
                        switch result {
                        case let .success(result):
                            isRecordingSaved = result
                        case let .failure(error):
                            print(error)
                        }
                    }
                }
            } else {
                Button("Delete Recording") {
                    persistenceService.delete(recording, of: recordingType)
                    isRecordingSaved = false
                }
            }
        }
        .onAppear {
            self.isRecordingSaved = persistenceService.isRecordingSaved(recording, of: recordingType)
        }
    }
}

struct SaveButton_Previews: PreviewProvider {
    static var previews: some View {
        SaveButton(persistenceService: AudioRecordingPersistenceService(user: User(username: "admin", userType: .admin)), recording: AudioRecording.previewRecording, recordingType: .outgoing)
    }
}
