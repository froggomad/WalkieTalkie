//
//  HistoryProgressView.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/1/21.
//

import SwiftUI

struct HistoryProgressView: View {
    var color: Color = ColorSheet.primaryColor
    var text: String = "loading your history..."
    
    var body: some View {
        ZStack {
            color
            VStack {
                LoadingAnimationView(color: color)
                    .frame(width: 125, height: 125, alignment: .center)
                Text(text)
            }
        }
    }
}

struct HistoryProgressView_Previews: PreviewProvider {
    static var previews: some View {
        HistoryProgressView()
    }
}
