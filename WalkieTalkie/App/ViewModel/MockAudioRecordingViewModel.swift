//
//  MockAudioRecordingViewModel.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/8/21.
//

import Foundation

class MockAudioRecordingViewModel: AudioRecordingViewModel {
    override init(apiService: APIManageable = MockAPIService(), audioService: AudioService = .init()) {
        super.init(apiService: apiService, audioService: audioService)
        incomingRecordings = [
            AudioRecording(id: 0, usernameFrom: "Bob", usernameTo: "Fred", timestamp: Date(), recording: "filename.mp3"),
            AudioRecording(id: 0, usernameFrom: "Bob", usernameTo: "Fred", timestamp: Date(), recording: "filename2.mp3"),
            AudioRecording(id: 0, usernameFrom: "Barbara", usernameTo: "Fred", timestamp: Date(), recording: "filename3.mp3")
        ]

        outgoingRecordings = [
            AudioRecording(id: 0, usernameFrom: "Fred", usernameTo: "Bob", timestamp: Date(), recording: "filename.mp3"),
            AudioRecording(id: 0, usernameFrom: "Fred", usernameTo: "Bob", timestamp: Date(), recording: "filename2.mp3"),
            AudioRecording(id: 0, usernameFrom: "Fred", usernameTo: "Barbara", timestamp: Date(), recording: "filename3.mp3")
        ]
    }
}
