//
//  AudioRecordingViewModel.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

class AudioRecordingViewModel: ObservableObject {
    @Published var incomingRecordings: [AudioRecording] = []
    @Published var outgoingRecordings: [AudioRecording] = []
    @Published var isLoading: Bool = false
    @Published var apiError: NetworkError? = nil
    let user = User(username: "Joe Satriani", userType: .admin)
    
    var audioService: AudioService
    let apiService: APIManageable
    
    init(apiService: APIManageable = APIService(), audioService: AudioService) {
        self.audioService = audioService
        self.apiService = apiService
        loadRecordingsFromAPI()
    }
    
    func loadRecordingsFromAPI(completion: @escaping () -> Void = {}) {
        isLoading = true
        apiService.processRequest(with: GetRecordingRequest()) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                    completion()
                }
            }
            guard let self = self else { return }
            
            switch result {
            case let .success(data):
                do {
                    let recordings: [AudioRecording] = try DataParser().parse(data: data)
                    DispatchQueue.main.async {
                        let sortingFrom: (AudioRecording, AudioRecording) -> Bool = { $0.unwrappedUsernameFrom < $1.unwrappedUsernameFrom }
                        
                        if self.user.userType == .admin {
                            self.incomingRecordings = recordings.sorted(by: sortingFrom)
                        } else {
                            self.incomingRecordings = recordings.filter { $0.usernameTo == self.user.username }.sorted(by: sortingFrom)
                            
                            self.outgoingRecordings = recordings.filter { $0.usernameFrom == self.user.username }.sorted(by: { $0.usernameTo < $1.usernameTo })
                        }
                        self.apiError = nil
                    }
                } catch {
                    print("Error Decoding Audio Recordings from API:", error.localizedDescription)
                    DispatchQueue.main.async {
                        self.apiError = .badDecode(error)
                    }
                }
            case let .failure(error):
                print("Error fetching Audio Recordings from API", error.localizedDescription)
                DispatchQueue.main.async {
                    self.apiError = error
                }
            }
        }
    }
}

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
