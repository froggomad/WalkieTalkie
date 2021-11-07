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
    @State private var listLoaded = false
    
    func emptyViewText(using geometry: GeometryProxy) -> some View {
        Text("Audio Transmissions will appear here when you have history to show")
            .font(.title)
            .padding(.horizontal, 20)
            .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
            .foregroundColor(ColorSheet.lightText)
            .multilineTextAlignment(.center)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                ColorSheet.primaryColor
                    .ignoresSafeArea()
                GeometryReader { geometry in
                    VStack {
                        // MARK: Loading View
                        if viewModel.isLoading && !listLoaded {
                            HistoryProgressView()
                        }
                        // MARK: Empty View
                        if viewModel.incomingRecordings.isEmpty && viewModel.outgoingRecordings.isEmpty {
                            if viewModel.apiError != nil {
                                VStack {
                                    if !viewModel.isLoading {
                                        Text("There was an error loading your transmissions")
                                        .font(.title)
                                        .padding(.horizontal, 20)
                                        .foregroundColor(ColorSheet.lightText)
                                        .multilineTextAlignment(.center)
                                        
                                        Button("Try again") {
                                            viewModel.loadRecordingsFromAPI()
                                        }
                                        .frame(width: 100, height: 33)
                                        .background(ColorSheet.actionColor)
                                        .foregroundColor(.white)
                                        .cornerRadius(8)
                                        .padding(.top, 20)
                                        .buttonStyle(ScaleButtonStyle())
                                    } else {
                                        emptyViewText(using: geometry)
                                    }
                                }
                                .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                            } else {
                                emptyViewText(using: geometry)
                            }
                        } else {
                            SearchBar(searchText: $searchText, isSearching: $isSearching)
                            List {
                                // refresh control
                                Section(header: RefreshControl(coordinateSpace: .named("refresh_history")) {
                                    if !viewModel.isLoading {
                                        viewModel.loadRecordingsFromAPI()
                                    }
                                }) {}
                                .hidden()
                                // refresh view
                                if viewModel.isLoading {
                                    HStack {
                                        Spacer()
                                        HistoryProgressView(color: .black)
                                        Spacer()
                                    }
                                }
                                // MARK: - Incoming Recordings -
                                if !viewModel.incomingRecordings.isEmpty {
                                    SectionView(recordingType: .incoming, searchText: $searchText, viewModel: viewModel, isSearching: $isSearching)
                                }
                                // MARK: - Outgoing Recordings -
                                if !viewModel.outgoingRecordings.isEmpty {
                                    SectionView(recordingType: .outgoing, searchText: $searchText, viewModel: viewModel, isSearching: $isSearching)
                                }
                            }
                            .navigationTitle("Transmission History")
                            // set section dropdown arrow color
                            .accentColor(ColorSheet.actionColor)
                            .onAppear(perform: {
                                listLoaded = true
                            })
                        }
                        
                    }
                }
                
            }
        }
        .navigationBarTitleTextColor(ColorSheet.lightText)
        // set back button color on destination view
        .accentColor(ColorSheet.lightText)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: AudioRecordingViewModel(apiService: MockAPIService(), audioService: AudioService()))
    }
}
