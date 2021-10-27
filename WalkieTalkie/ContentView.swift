//
//  ContentView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/27/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        Button(action: {
            do {
                let audioRecordingData: [AudioRecording] = try DataParser().parse(data: AudioRecording.mockData)
                print(audioRecordingData)
            } catch {
                print(error)
            }
        }, label: {Text("Hi")})
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
