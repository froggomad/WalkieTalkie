//
//  AudioRecordingPersistenceService.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/9/21.
//

import Foundation

class AudioRecordingPersistenceService {
    private let persistenceController = LocalPersistenceController()
    private let apiService = APIService()

    let user: User

    init(user: User) {
        self.user = user
    }

    func save(_ recording: AudioRecording, of type: RecordingType, completion: @escaping (Result<Bool, Error>) -> Void) {
        let url = recording.url
        let request = URLRequest(url: url)
        apiService.processURLRequest(request) { result in
            switch result {
            case let .success(data):
                completion(
                    .success(
                        self.persistenceController.save(data: data,
                                                        filePath: self.filePath(using: recording, of: type),
                                                        directoryPath: self.directoryPath(using: recording, of: type))
                    )
                )
            case let .failure(error):
                completion(.failure(error))
            }
        }
    }

    func load(_ recording: AudioRecording, of type: RecordingType) -> URL? {
        let url = recordingURL(using: recording, of: type)
        if FileManager.default.fileExists(atPath: url.path) {
            return url
        }
        return nil
    }

    func recordingURL(using recording: AudioRecording, of type: RecordingType) -> URL {
        persistenceController.userDocumentPath(filePath(using: recording, of: type))
    }

    @discardableResult func delete(_ recording: AudioRecording, of type: RecordingType) -> Bool {
        do {
            let url = recordingURL(using: recording, of: type)
            try FileManager.default.removeItem(at: url)
            return FileManager.default.fileExists(atPath: url.absoluteString)
        } catch {
            print(error)
            return false
        }
    }

    private func filePath(using recording: AudioRecording, of type: RecordingType) -> String {
        // check for directory in filename
        let filename = recording.recording.components(separatedBy: "/")
        let recordingFilename: String = filename.count > 1 ? filename.last! : recording.recording
        return directoryPath(using: recording, of: type) + "/" + recordingFilename
    }

    private func directoryPath(using recording: AudioRecording, of type: RecordingType) -> String {
        let storedUser = type == .outgoing ? recording.usernameTo : recording.unwrappedUsernameFrom
        return "recordings/\(user.username)/\(type)/\(storedUser)/\(recording.timestamp.description)"
    }

    func isRecordingSaved(_ recording: AudioRecording, of type: RecordingType) -> Bool {
        return persistenceController.isFilePersisted(at: filePath(using: recording, of: type))
    }
}
