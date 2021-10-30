//
//  HistoryView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: AudioRecordingViewModel
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if viewModel.isLoading {
                    ProgressView("loading...")
                        .padding(.top, 20)
                }
                // MARK: Empty View
                if viewModel.incomingRecordings.isEmpty && viewModel.outgoingRecordings.isEmpty {
                    Text("Audio Recordings will appear here when you have history to show")
                        .font(.title)
                        .padding(.horizontal, 20)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                }
                
                NavigationView {
                    VStack {
                        SearchBar(searchText: $searchText, isSearching: $isSearching)
                        
                        List {
                            let searchService = SearchService()
                            // MARK: - Incoming Recordings -
                            if !viewModel.incomingRecordings.isEmpty {
                                Section(header: Text("Incoming Recordings")) {
                                    let filteredIncomingRecordings = searchService.search(for: $searchText, in: viewModel.incomingRecordings, recordingType: .incoming)

                                    let incomingRecordings = filteredIncomingRecordings.isEmpty && isSearching == false ? viewModel.incomingRecordings : filteredIncomingRecordings
                                    
                                    ForEach(incomingRecordings) { recording in
                                        RecordingRow(audioService: viewModel.audioService, recording: recording)
                                    }
                                }
                            }
                            
                            // MARK: - Outgoing Recordings -
                            if !viewModel.outgoingRecordings.isEmpty {
                                Section(header: Text("Outgoing Recordings")) {
                                    
                                    let filteredOutgoingRecordings =
                                    searchService.search(for: $searchText, in: viewModel.outgoingRecordings, recordingType: .outgoing)
                                    
                                    let outgoingRecordings = filteredOutgoingRecordings.isEmpty && isSearching == false ?
                                    viewModel.outgoingRecordings : filteredOutgoingRecordings
                                    
                                    ForEach(outgoingRecordings) { recording in
                                        RecordingRow(audioService: viewModel.audioService, recording: recording)
                                    }
                                }
                            }
                        }
                    }
                }
            }
            
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: AudioRecordingViewModel(apiService: MockAPIService(), audioService: AudioService()))
    }
}
