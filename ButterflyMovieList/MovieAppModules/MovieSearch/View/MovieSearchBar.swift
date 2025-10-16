//
//  ModernSearchBar.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-16.
//


import SwiftUI

struct MovieSearchBar: View {
    @Binding var text: String
    @State private var isEditing = false

    var placeholder: String = "Search movies..."

    var body: some View {
        HStack {
            HStack {
                Image(systemName: "magnifyingglass")
                    .foregroundColor(.secondary)
                
                TextField(placeholder, text: $text)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
                    .onTapGesture {
                        withAnimation {
                            isEditing = true
                        }
                    }
                
                if !text.isEmpty {
                    Button(action: {
                        self.text = ""
                    }) {
                        Image(systemName: "xmark.circle.fill")
                            .foregroundColor(.secondary)
                    }
                }
            }
            .padding(10)
            .background(Color(.systemGray6))
            .cornerRadius(10)
            .shadow(color: Color.black.opacity(0.05), radius: 5, x: 0, y: 2)
            
            if isEditing {
                Button(action: {
                    withAnimation {
                        text = ""
                        isEditing = false
                        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
                    }
                }) {
                    Text("Cancel")
                        .foregroundColor(.blue)
                }
                .transition(.move(edge: .trailing))
            }
        }
        .padding(.horizontal)
        .animation(.default, value: isEditing)
    }
}

// MARK: - Preview

struct ModernSearchBar_Previews: PreviewProvider {
    struct PreviewWrapper: View {
        @State private var searchText = "Inception"
        var body: some View {
            VStack {
                MovieSearchBar(text: $searchText)
                Spacer()
                Text("Typed: \(searchText)")
                    .foregroundColor(.gray)
            }
            .padding()
        }
    }
    
    static var previews: some View {
        Group {
            PreviewWrapper()
                .previewDisplayName("Light Mode")
            
            PreviewWrapper()
                .preferredColorScheme(.dark)
                .previewDisplayName("Dark Mode")
        }
    }
}
