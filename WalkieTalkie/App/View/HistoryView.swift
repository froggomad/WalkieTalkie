//
//  HistoryView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI
import AVFoundation

struct HistoryView: View {
    @ObservedObject var viewModel: AudioRecordingViewModel
    
    var body: some View {
        GeometryReader { geometry in
            VStack {
                if viewModel.isLoading {
                    ProgressView("loading...")
                        .padding([.top], 20)
                }
                // MARK: Empty View
                if viewModel.incomingRecordings.isEmpty && viewModel.outgoingRecordings.isEmpty {
                    Spacer()
                    
                    Text("Audio Recordings will appear here when you have history to show")
                        .font(.title)
                        .padding([.leading, .trailing], 20)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    
                    Spacer()
                }
                
                List {
                    if !viewModel.incomingRecordings.isEmpty {
                        Section(header:
                                    Text("Incoming Recordings")) {
                            
                            ForEach(viewModel.incomingRecordings) { recording in
                                RecordingRow(audioService: viewModel.audioService, recording: recording)
                            }
                        }
                    }
                    
                    if !viewModel.outgoingRecordings.isEmpty {
                        Section(header:
                                    Text("Outgoing Recordings")) {
                            
                            ForEach(viewModel.outgoingRecordings) { recording in
                                RecordingRow(audioService: viewModel.audioService, recording: recording)
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
