//
//  ClearButtonViewModifier.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/29/21.
//

import SwiftUI

public struct ClearButton: ViewModifier {
    @Binding var text: String
    
    public init(text: Binding<String>) {
        self._text = text
    }
    
    public func body(content: Content) -> some View {
        HStack {
            ZStack {
                content
                Image(systemName: "multiply.circle.fill")
                    .foregroundColor(.secondary)
                    .opacity(text == "" ? 0 : 1)
                    .onTapGesture { self.text = "" }
                    .foregroundColor(ColorSheet.lightText)
                    .frame(maxWidth: .infinity, alignment: .trailing)
            }
        }
    }
}
