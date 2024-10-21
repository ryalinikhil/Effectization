//
//  ContentView.swift
//  Effectization
//
//  Created by Sameer Nikhil on 21/10/24.
//

import SwiftUI
import CoreData
import UIKit

struct ContentView: View {
    var body: some View {
        ZStack{
            Color.clear
        }
    }
}

#Preview {
    HomeView()
}



struct HomeView: View {
    @State private var tabSelected: Tab = .person
    @State private var showTabBar: Bool = true
    init() {
        UITabBar.appearance().isHidden = true
    }
    
    var body: some View {
        ZStack{
                ZStack {
                    VStack {
                        TabView(selection: $tabSelected) {
                            ForEach(Tab.allCases, id: \.rawValue) { tab in
                                tabContent(for: tab)
                                    .tag(tab)
                                
                            }
                            
                        }
                    }
                    VStack {
                        Spacer()
                        CustomTabBar(selectedTab: $tabSelected)
                    }
                }
                .statusBarHidden()

        }
    }
 

    
    private func tabContent(for tab: Tab) -> some View {
        switch tab {
        case .person:
           // return AnyView( MainView()) - showTabBar: $showTabBar
            return AnyView(MainView(showTabBar: $showTabBar))
            
        case .gearshape:
            return AnyView(FormView()
            )
        }
    }
}

enum Tab: String, CaseIterable {
    case person = "arkit"
    case gearshape = "gear"
}

struct CustomTabBar: View {
    @Binding var selectedTab: Tab

    private var tabColor: Color {
        switch selectedTab {
        case .person:
            return .blue
        case .gearshape:
            return .blue
        }
    }

    var body: some View {
        HStack {
            ForEach(Tab.allCases, id: \.rawValue) { tab in
                Spacer()
                Image(systemName: tab.rawValue)
                    .foregroundColor(tab == selectedTab ? tabColor : .white)
                    .font(.system(size: 27))    // 25 - initial
                    .onTapGesture {
                        withAnimation(.easeInOut(duration: 0.25)) {
                            selectedTab = tab
                            
                            // Add haptic feedback here
                           UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                            // Haptic intensity:    .heavy    .medium   .light  .rigid  .soft
                                                 
                        }
                    }
                Spacer()
            }
       //     .symbolEffect(.bounce.up.wholeSymbol)

        }
        .frame(width: .infinity, height: 95)  // 60 x 240 - initial
        .background(.thinMaterial)
        .preferredColorScheme(.dark)
        .cornerRadius(0)
        .padding(.bottom, 0)
        .overlay(
            RoundedRectangle(cornerRadius: 0)
                .inset(by: 0.5)
                .stroke(.black.opacity(0.7), lineWidth: 0)
        )
        .padding(.bottom,-40)
    }
}



//MARK:- 2

import SwiftUI

struct TabBarView: View {
    @State private var selectedTab: Int = 0
    @State private var showTabBar: Bool = true // Control to show/hide tab bar
    
    var body: some View {
            VStack(spacing: 0) {
                // Tab content
                ZStack {
                    switch selectedTab {
                    case 0:
                        MainView(showTabBar: $showTabBar) // Passing showTabBar binding
                    case 2:
                        FormView()
                    default:
                        MainView(showTabBar: $showTabBar)
                    }
                }
                Spacer()
                
                // Conditionally show the tab bar
                if showTabBar {
                    CustomTabBar2(selectedTab: $selectedTab)
                }
            }
            .edgesIgnoringSafeArea(.bottom)
    }
}

struct CustomTabBar2: View {
    @Binding var selectedTab: Int

    var body: some View {
        ZStack {
          //  Color.clear
            //    .frame(height: 5.5)
              //  .shadow(radius: 5)
            
            
            HStack {
                Spacer()
                
                // Tab Button with custom image and color
                TabBarButton(
                    icon: "arkit",
                    title: "Tab1",
                    isSelected: selectedTab == 0
                ) {
                    selectedTab = 0
                }
                .foregroundColor(selectedTab == 0 ? .blue : .gray)
                
                Spacer()
                Spacer()
                
                TabBarButton(
                    icon: "gear", // Custom image for "My Account"
                    title: "Tab2",
                    isSelected: selectedTab == 2
                ) {
                    selectedTab = 2
                }
                .foregroundColor(selectedTab == 2 ? .blue : .gray)
                
                Spacer()
            }
            .padding(.bottom)
            
        }
        //.frame(height: 80)
        .background(.thinMaterial)
        .preferredColorScheme(.dark)
        .overlay(
                    RoundedRectangle(cornerRadius: 0)
                        .inset(by: 0.5)
                        .stroke(.black.opacity(0.7), lineWidth: 1)
                )
    }
}

struct TabBarButton: View {
    var icon: String
    var title: String
    var isSelected: Bool
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            VStack {
                Image(systemName: icon)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 42, height: 27)
                    .foregroundColor(isSelected ? .blue : .white)

            }
        }
        .padding()
    }
}

struct ProfileView: View {
    @Binding var showTabBar: Bool // Binding to control tab bar visibility
    
    var body: some View {
        NavigationView {
            VStack {
                Image("prof_view")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .ignoresSafeArea()
                
                NavigationLink(destination: DetailView(showTabBar: $showTabBar)) {
                    Text("Go to Details")
                        .font(.title)
                        .padding()
                }
            }
        }
        .statusBarHidden()
        .onAppear {
            showTabBar = true // Show the tab bar when this view appears
        }
    }
}

struct DetailView: View {
    @Binding var showTabBar: Bool // Control tab bar visibility in DetailView
    
    var body: some View {
        VStack {
            Text("Details Screen")
                .font(.largeTitle)
                .padding()
            
            Button(action: {
                showTabBar = true // Show the tab bar again when navigating back
            }) {
                Text("Back")
            }
        }
        .onAppear {
            showTabBar = false // Hide the tab bar when this view appears
        }
    }
}

#Preview {
    TabBarView()
}
