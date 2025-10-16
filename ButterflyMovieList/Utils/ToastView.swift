//
//  ToastView.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-17.
//


import SwiftUI

struct ToastView: View {
    let message: String

    var body: some View {
        Text(message)
            .frame(maxWidth: .infinity, alignment: .center)
            .foregroundColor(.white)
            .padding()
            .background(Color.red.opacity(0.8))
            .cornerRadius(10)
            .shadow(radius: 5)
            .padding(.horizontal, 20)
    }
}

// Preview
struct ToastView_Previews: PreviewProvider {
    static var previews: some View {
        ToastView(message: "This is a sample toast message.")
    }
}
        
        
        
