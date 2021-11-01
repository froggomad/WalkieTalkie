//
//  ToFromUser.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/1/21.
//
protocol ToFromUser {
    var recording: AudioRecording { get set }
    var recordingType: RecordingType { get }
    var toFromLabel: String { get }
    var toFromUsername: String { get }
}

extension ToFromUser {
    var toFromLabel: String {
        return recordingType == .outgoing ? "To: " : "From: "
    }
    var toFromUsername: String {
        return recordingType == .outgoing ? recording.usernameTo : recording.usernameFrom ?? "Anonymous"
    }
}
