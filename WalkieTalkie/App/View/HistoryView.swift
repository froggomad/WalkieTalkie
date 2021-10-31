//
//  HistoryView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI

struct HistoryView: View {
    @ObservedObject var viewModel: AudioRecordingViewModel = .init(audioService: AudioService())
    @State private var searchText = ""
    @State private var isSearching = false
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorSheet.primaryColor
                    .ignoresSafeArea()
                GeometryReader { geometry in
                    VStack {
                        // MARK: Loading View
                        if viewModel.isLoading {
                            ProgressView("loading...")
                                .padding(.top, 20)
                                .foregroundColor(ColorSheet.lightText)
                                .progressViewStyle(CircularProgressViewStyle(tint: ColorSheet.lightText))
                        }
                        // MARK: Empty View
                        if viewModel.incomingRecordings.isEmpty && viewModel.outgoingRecordings.isEmpty {
                            Text("Audio Recordings will appear here when you have history to show")
                                .font(.title)
                                .padding(.horizontal, 20)
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                                .foregroundColor(ColorSheet.lightText)
                        } else {
                            SearchBar(searchText: $searchText, isSearching: $isSearching)
                            
                            List {
                                // MARK: - Incoming Recordings -
                                if !viewModel.incomingRecordings.isEmpty {
                                    SectionView(recordingType: .incoming, searchText: $searchText, viewModel: .constant(viewModel), isSearching: $isSearching)
                                }
                                
                                // MARK: - Outgoing Recordings -
                                if !viewModel.outgoingRecordings.isEmpty {
                                    SectionView(recordingType: .outgoing, searchText: $searchText, viewModel: .constant(viewModel), isSearching: $isSearching)
                                }
                            }
                            .navigationTitle("History")
                            .navigationBarTitleTextColor(ColorSheet.lightText)
                            // set section dropdown arrow color
                            .accentColor(ColorSheet.actionColor)
                        }
                        
                    }
                }
                
            }
        }
        // set back button color on destination view
        .accentColor(ColorSheet.lightText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: AudioRecordingViewModel(apiService: MockAPIService(), audioService: AudioService()))
    }
}
