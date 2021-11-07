//
//  RefreshControl.swift
//  WalkieTalkie
//
//  Created by Kenneth Dubroff on 11/1/21.
//
import SwiftUI
/// This class provides pull-to-refresh functionality. However, a loading indicator must be provided outside of the class
struct RefreshControl: View {
    var coordinateSpace: CoordinateSpace
    var onRefresh: () -> Void
    var body: some View {
        GeometryReader { geo in
            if (geo.frame(in: coordinateSpace).midY > 250) {
                Spacer()
                    .onAppear {
                        onRefresh() //call refresh once
                    }
            }
        }
    }
}
