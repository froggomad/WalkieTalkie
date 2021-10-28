//
//  ContentView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var viewModel: AudioRecordingViewModel
    
    var body: some View {
        List {
            ForEach(viewModel.recordings) { recording in
                RecordingRow(recording: recording)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView(viewModel: AudioRecordingViewModel(apiService: MockAPIService()))
    }
}
