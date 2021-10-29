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
                
                if viewModel.recordings.isEmpty {
                    Spacer()
                    
                    Text("Audio Recordings will appear here when you have history to show")
                        .font(.title)
                        .padding([.leading, .trailing], 20)
                        .frame(width: geometry.size.width, height: geometry.size.height, alignment: .center)
                    
                    Spacer()
                }
                List {
                    ForEach(viewModel.recordings) { recording in
                        RecordingRow(recording: recording)
                    }
                }
            }
        }

    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryView(viewModel: AudioRecordingViewModel(apiService: MockAPIService()))
    }
}
