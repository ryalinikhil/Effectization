//
//  SideView.swift
//  Effectization
//
//  Created by Sameer Nikhil on 21/10/24.
//

import SwiftUI

struct SideView: View {
    var body: some View {
        ZStack{
            Color.black
                .edgesIgnoringSafeArea(.all)
          /*  Rectangle()
                 .foregroundColor(.clear)
                 .frame(width: 411, height: 897)
                 .background(Color(red: 0.09, green: 0.09, blue: 0.31));*/
            
            Image("Thumb")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .ignoresSafeArea()

            
            VStack{
                HStack{
                    Text("")
                        .font( .largeTitle)
                        .bold()
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.horizontal)
                
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 325, height: 256)
                    .background(.ultraThinMaterial.opacity(0.9)) // Built-in material for blur effect
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.24), lineWidth: 1)
                    )
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.20), lineWidth: 1)
                    )
                    .shadow(
                        color: Color.black.opacity(0.16), radius: 16, y: 8
                    )
                
                Rectangle()
                    .foregroundColor(.clear)
                    .frame(width: 325, height: 256)
                    .background(BlurView(style: .light)) // Set to .light for stronger blur but keep it subtle
                    .cornerRadius(20)
                    .overlay(
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.white.opacity(0.15), lineWidth: 1) // Lighter stroke for less emphasis
                    )
                    .background(Color.white.opacity(0.05)) // Slight white tint to enhance glassmorphism
                    .shadow(
                        color: Color.black.opacity(0.05), radius: 16, y: 8 // Soften the shadow
                    )
                
            }
        }
    }
}



#Preview {
        SideView()
}



import SwiftUI

// Custom BlurView with style for different blur effects
struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style

    func makeUIView(context: Context) -> UIVisualEffectView {
        let blurEffect = UIBlurEffect(style: style)
        let view = UIVisualEffectView(effect: blurEffect)
        return view
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}




