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
        URLSession.shared.dataTask(with: request) { data, _, error in
            if let error = error {
                completion(.failure(error))
                return
            }

            guard let data = data else {
                completion(.failure(NetworkError.noData))
                return
            }

            completion(
                .success(
                    self.persistenceController.save(data: data,
                                                    to: self.path(using: recording, of: type))
                )
            )
        }.resume()
    }

    func load(_ recording: AudioRecording, of type: RecordingType) -> URL {
        return persistenceController.userDocumentPath(path(using: recording, of: type))
    }

    private func path(using recording: AudioRecording, of type: RecordingType) -> String {
        let storedUser = type == .outgoing ? recording.usernameTo : recording.unwrappedUsernameFrom
        return "recordings/\(user.username)/\(type)/\(storedUser)\(recording.recording)"
    }
}
