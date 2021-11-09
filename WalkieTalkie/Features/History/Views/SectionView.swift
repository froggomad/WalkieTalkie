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
    @Binding var isSearching: Bool
    @State var searchService: SearchService = .init()
    
    var recordingText: String {
        NSLocalizedString("\(recordingType.rawValue.capitalized) Transmissions", comment: "History list section label")
    }
    
    var body: some View {
        Section(header: Text(recordingText)) {
            let recordingsToUse = recordingType == .outgoing ? viewModel.outgoingRecordings : viewModel.incomingRecordings
            
            let filteredIncomingRecordings = searchService.search(for: $searchText, in: recordingsToUse, recordingType: recordingType)
            
            let filteredRecordings = filteredIncomingRecordings.isEmpty ? recordingsToUse : filteredIncomingRecordings
            
            ForEach(filteredRecordings) { recording in
                NavigationLink(destination: PlaybackView(recording: recording, audioService: viewModel.audioService, recordingType: recordingType)) {
                    RecordingRow(audioService: viewModel.audioService, recording: recording, recordingType: recordingType)
                }
            }
        }
    }
}

struct SectionView_Previews: PreviewProvider {
    static var previews: some View {
        SectionView(recordingType: .outgoing, searchText: .constant(""), viewModel: MockAudioRecordingViewModel(), isSearching: .constant(false))
    }
}
