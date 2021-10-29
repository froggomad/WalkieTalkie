//
//  AudioRecordingViewModel.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import Foundation

class AudioRecordingViewModel: ObservableObject {
    @Published var recordings: [AudioRecording] = []
    @Published var isLoading: Bool = false
    var audioService = AudioService.shared
    
    let apiService: APIManageable
    
    init(apiService: APIManageable = APIService()) {
        self.apiService = apiService
        isLoading = true
        loadRecordingsFromAPI()
    }
    
    func loadRecordingsFromAPI() {
        apiService.processRequest(with: GetRecordingRequest()) { [weak self] result in
            defer {
                DispatchQueue.main.async {
                    self?.isLoading = false
                }
            }
            switch result {
            case let .success(data):
                do {
                    let recordings: [AudioRecording] = try DataParser().parse(data: data)
                    
                    DispatchQueue.main.async {
                        self?.recordings = recordings
                    }
                } catch {
                    print("Error Decoding Audio Recordings from API:", error.localizedDescription)
                }
            case let .failure(error):
                print("Error fetching Audio Recordings from API", error.localizedDescription)
            }
        }
    }
}
