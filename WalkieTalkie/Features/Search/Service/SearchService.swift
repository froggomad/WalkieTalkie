//
//  SearchService.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/29/21.
//

import Foundation

class SearchService {
    enum RecordingType {
        case incoming
        case outgoing
    }
    
    func search(for searchText: String, in searchArray: [AudioRecording], recordingType: RecordingType) -> [AudioRecording] {
        switch recordingType {
        case .incoming:
            return searchArray.filter {
                let usernameFrom = $0.usernameFrom ?? ""
                return usernameFrom.contains(searchText)
            }
        case .outgoing:
            return searchArray.filter { $0.usernameTo.contains(searchText) }
        }
        
    }
}
