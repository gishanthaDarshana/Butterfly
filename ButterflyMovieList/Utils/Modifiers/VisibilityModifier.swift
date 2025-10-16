//
//  VisibilityModifier.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-17.
//


import SwiftUI

struct VisibilityModifier: ViewModifier {
    @Binding var isVisible: Bool

    func body(content: Content) -> some View {
        Group {
            if isVisible {
                content
            } else {
                EmptyView()
            }
        }
    }
}

public extension View {
    func isVisible(_ isVisible: Binding<Bool>) -> some View {
        self.modifier(VisibilityModifier(isVisible: isVisible))
    }
}