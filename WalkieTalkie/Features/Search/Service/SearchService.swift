//
//  SearchService.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/29/21.
//
import Foundation
import SwiftUI

enum RecordingType: String {
    case incoming
    case outgoing
}

class SearchService {    
    func search(for searchText: Binding<String>, in searchArray: [AudioRecording], recordingType: RecordingType) -> [AudioRecording] {
        switch recordingType {
        case .incoming:
            return searchArray.filter {
                let usernameFrom = $0.unwrappedUsernameFrom
                return usernameFrom.lowercased().contains(searchText.wrappedValue.lowercased())
            }
        case .outgoing:
            return searchArray.filter {
                $0.usernameTo.lowercased().contains(searchText.wrappedValue.lowercased())
            }
        }
        
    }
}
