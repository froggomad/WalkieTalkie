//
//  SearchBar.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 10/29/21.
//

import SwiftUI

struct SearchBar: View {
    @Binding var searchText: String
    @Binding var isSearching: Bool
    /// used to dismiss the TextField's keyboard
    @State var textFieldId: String = UUID().uuidString
    
    var body: some View {
        HStack {
            TextField("Search for username", text: $searchText)
                .id(textFieldId)
                .padding(8)
                .background(Color(.systemGray5))
                .cornerRadius(6)
                .padding(.horizontal, 20)
                .onTapGesture {
                    isSearching = true
                }
            
            if isSearching {
                Button("cancel") {
                    isSearching = false
                    // changing the ID dismisses the keyboard
                    textFieldId = UUID().uuidString
                }
                .padding(.trailing, 12)
            }
        }
    }
}

struct SearchBar_Previews: PreviewProvider {
    static var previews: some View {
        SearchBar(searchText: .constant("far"), isSearching: .constant(true))
    }
}
