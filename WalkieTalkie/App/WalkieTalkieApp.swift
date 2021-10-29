//
//  WalkieTalkieApp.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI

@main
struct WalkieTalkieApp: App {
    var body: some Scene {
        WindowGroup {
            HistoryView(viewModel: AudioRecordingViewModel(audioService: AudioService()))
        }
    }
}
