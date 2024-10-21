//
//  CameraAccessView.swift
//  Effectization
//
//  Created by Sameer Nikhil on 23/10/24.
//
import SwiftUI


struct CameraAccessPromptView: View {
    var body: some View {
        VStack {
            Text("Enable Camera Access")
                .font(.largeTitle)
                .padding()
            Text("Please enable camera access in your device settings to use the QR code scanner.")
                .multilineTextAlignment(.center)
                .padding()
            Button(action: {
                // Logic to navigate back to main screen or dismiss
            }) {
                Text("Go Back")
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
        }
        .padding()
    }
}
