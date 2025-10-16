//
//  ToastModifier.swift
//  ButterflyMovieList
//
//  Created by Gishantha Darshana on 2025-10-17.
//
import SwiftUI

struct ToastModifier: ViewModifier {
    @Binding var isPresented: Bool
    let message: String
    var backgroundColor: Color = .red
    var duration: Double = 2

    func body(content: Content) -> some View {
        ZStack {
            content

            if isPresented {
                VStack {
                    Spacer()
                    ToastView(message: message)
                        .transition(.move(edge: .bottom).combined(with: .opacity))
                }
                .animation(.easeInOut, value: isPresented)
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + duration) {
                        withAnimation {
                            isPresented = false
                        }
                    }
                }
            }
        }
    }
}

extension View {
    func toast(isPresented: Binding<Bool>, message: String, backgroundColor: Color = .red, duration: Double = 2) -> some View {
        self.modifier(ToastModifier(isPresented: isPresented, message: message, backgroundColor: backgroundColor, duration: duration))
    }
}


// Preview
struct ToastModifier_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            Text("Hello, World!")
                .toast(isPresented: .constant(true), message: "This is a toast message")
        }
    }
}
