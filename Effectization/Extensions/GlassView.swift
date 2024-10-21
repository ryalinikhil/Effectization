//
//  GlassView.swift
//  Effectization
//
//  Created by Sameer Nikhil on 24/10/24.
//

import WidgetKit
import SwiftUI
import UIKit

struct blur22: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 195, height: 55)
            .background(BlurView(style: .light)) // Set to .light for stronger blur but keep it subtle
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1) // Lighter stroke for less emphasis
            )
            .background(Color.white.opacity(0.05))
            .cornerRadius(40)
        // Slight white tint to enhance glassmorphism
            .shadow(
                color: Color.black.opacity(0.05), radius: 16, y: 8 // Soften the shadow
            )
    }
}

struct blur23: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 95, height: 55)
            .background(BlurView(style: .light)) // Set to .light for stronger blur but keep it subtle
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.15), lineWidth: 1) // Lighter stroke for less emphasis
            )
            .background(Color.white.opacity(0.05))
            .cornerRadius(40)
        // Slight white tint to enhance glassmorphism
            .shadow(
                color: Color.black.opacity(0.05), radius: 16, y: 8 // Soften the shadow
            )
    }
}

struct blur24: View {
    var body: some View {
        Rectangle()
            .foregroundColor(.clear)
            .frame(width: 65, height: 65)
            .background(BlurView(style: .light)) // Set to .light for stronger blur but keep it subtle
            .cornerRadius(40)
            .overlay(
                RoundedRectangle(cornerRadius: 40)
                    .stroke(Color.white.opacity(0.25), lineWidth: 1) // Lighter stroke for less emphasis
            )
            .background(Color.white.opacity(0.25))
            .cornerRadius(40)
        // Slight white tint to enhance glassmorphism
            .shadow(
                color: Color.black.opacity(0.05), radius: 16, y: 8 // Soften the shadow
            )
    }
}
