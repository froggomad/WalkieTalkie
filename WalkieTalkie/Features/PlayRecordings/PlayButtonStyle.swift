//
//  PlayButtonStyle.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/2/21.
//

import SwiftUI

struct PlayButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 1.5 : 1.0)
    }
}
