//
//  HistoryProgressView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/1/21.
//

import SwiftUI

struct HistoryProgressView: View {
    var color: Color = ColorSheet.lightText
    
    var body: some View {
        ProgressView("loading...")
            .foregroundColor(color)
            .progressViewStyle(CircularProgressViewStyle(tint: color))
    }
}

struct HistoryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.black
            HistoryProgressView()
        }
        HistoryProgressView(color: .black)
    }
}
