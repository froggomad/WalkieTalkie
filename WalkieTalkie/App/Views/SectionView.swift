//
//  SectionView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/31/21.
//

import SwiftUI

struct SectionView: View {
    @State var recordingType: RecordingType
    @Binding var searchText: String
    @State var viewModel: AudioRecordingViewModel
    @State var isSearching: Bool
    @State var searchService: SearchService = .init()
    
    var recordingText: String {
        "\(recordingType.rawValue.capitalized) Recordings"
    }
    
    var body: some View {
        Section(header: Text(recordingText)) {
            
            if recordingType == .incoming {
                let filteredIncomingRecordings = searchService.search(for: $searchText, in: viewModel.incomingRecordings, recordingType: .incoming)
                
                let filteredRecordings = filteredIncomingRecordings.isEmpty && isSearching == false ? viewModel.incomingRecordings : filteredIncomingRecordings
                
                ForEach(filteredRecordings) { recording in
                    NavigationLink(destination: PlaybackView(recording: recording, audioService: viewModel.audioService)) {
                        RecordingRow(audioService: viewModel.audioService, recording: recording)
                    }
                }
            } else {
                let filteredOutgoingRecordings =
                searchService.search(for: $searchText, in: viewModel.outgoingRecordings, recordingType: .outgoing)
                
                let filteredRecordings = filteredOutgoingRecordings.isEmpty && isSearching == false ?
                viewModel.outgoingRecordings : filteredOutgoingRecordings
                
                ForEach(filteredRecordings) { recording in
                    NavigationLink(destination: PlaybackView(recording: recording, audioService: viewModel.audioService)) {
                        RecordingRow(audioService: viewModel.audioService, recording: recording)
                    }
                }
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(recordingType: .outgoing, searchText: .constant(""), viewModel: MockAudioRecordingViewModel(), isSearching: false)
    }
}
