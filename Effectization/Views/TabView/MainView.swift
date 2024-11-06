//
//  HomeView.swift
//  Effectization
//
//  Created by Sameer Nikhil on 21/10/24.
//

import SwiftUI

struct MainView: View {
    @State private var selectedCategory: WorkoutCategory? = nil
    @Binding var showTabBar: Bool
    @State private var isContentView67Presented = false
    
    var body: some View {
        NavigationStack {
        ZStack{
            Color.black
                .ignoresSafeArea()
            ScrollView(showsIndicators: false) {
                VStack {
                    // Title Section
                    VStack(alignment: .leading) {
                        HStack{
                            ZStack{
                                Text("Effetization")
                                    .font(.system(size: 44, weight: .bold))
                                    .foregroundColor(Color.green)
                            }
                            Spacer()
                           // NavigationLink(
                             //   destination: ContentView67(showTabBar: $showTabBar)
                        Button(action: {
                                                isContentView67Presented.toggle()
                                            })
                             {
                                ZStack{
                                    blur24()
                                    Image(systemName: "viewfinder")
                                        .resizable()
                                        .frame(width: 23, height: 23)
                                        .foregroundStyle(.white)
                                }
                            }
                        }
                        HStack(spacing: 0){
                            Text("Studio")
                                .font(.system(size: 44, weight: .bold))
                                .foregroundColor(Color.white)
                        }
                        .padding(.top,-30)
                    }
                    .padding(.horizontal)
                    .padding(.top, 10)
                    
                    ContentView2()
                    
                    Spacer()
                    }
                .fullScreenCover(isPresented: $isContentView67Presented) {
                               ContentView67(showTabBar: $showTabBar)
                           }
                }
            }
        }
        .navigationBarBackButtonHidden(true)
        .onAppear {
            showTabBar = true // Show the tab bar when this view appears
        }
    }
}

import SwiftUI

struct WorkoutCategory: Identifiable {
    let id = UUID()
    let name: String
    let subcategories: [WorkoutSubcategory]
}

struct WorkoutSubcategory: Identifiable {
    let id = UUID()
    let title: String
    let duration: String
    let image: String
    let link: String // External link for subcategories
}

struct ContentView2: View {
    @State private var selectedCategory: WorkoutCategory? = nil
    
    let categories = [
        //MARK:- CATEGORY 1
        WorkoutCategory(name: "AR", subcategories: [
            WorkoutSubcategory(title: "SnapChat Lenses", duration: "SnapChat", image: "img1", link: "https://www.snapchat.com"),WorkoutSubcategory(title: "SnapChat Lenses", duration: "SnapChat", image: "img2", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "Tiktok Filters", duration: "SnapChat", image: "img3", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "WebAR", duration: "SnapChat", image: "img5", link: "https://www.snapchat.com")
        ]),
        //MARK:- CATEGORY 3
        WorkoutCategory(name: "Web Apps", subcategories: [
            WorkoutSubcategory(title: "Hyper Casual Game", duration: "25 min", image: "img4", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "Branded Activation", duration: "25 min", image: "img9", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "Web Tools", duration: "25 min", image: "img10", link: "https://www.snapchat.com")
        ]),
        //MARK:- CATEGORY 2
        WorkoutCategory(name: "CGI", subcategories: [
            WorkoutSubcategory(title: "Static Renders", duration: "20 min", image: "img7", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "CGI Videos", duration: "20 min", image: "img6", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "VFX Videos", duration: "20 min", image: "img8", link: "https://www.snapchat.com")
        ]),
        //MARK:- CATEGORY 4
        WorkoutCategory(name: "AI", subcategories: [
            WorkoutSubcategory(title: "Content Creation", duration: "25 min", image: "img11", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "AI Web App", duration: "25 min", image: "img12", link: "https://www.snapchat.com"),
            WorkoutSubcategory(title: "AI Tool", duration: "25 min", image: "img13", link: "https://www.snapchat.com")
        ])

    ]
    
    init() {
           // Set the first category as the default selected category
           _selectedCategory = State(initialValue: categories.first)
       }
    var body: some View {
           ZStack {
               Color.black
                   .ignoresSafeArea()
               
               VStack {
                   // Horizontal Scroll for Categories
                   ScrollView(.horizontal, showsIndicators: false) {
                       HStack {
                           ForEach(categories) { category in
                               Button(action: {
                                   selectedCategory = category
                               }) {
                                   Text(category.name)
                                       .font(.system(size: 22.5, weight: .bold))
                                       .padding(.horizontal, 29)
                                       .padding(.vertical, 12)
                                       .background(selectedCategory?.id == category.id ? Color.white : Color.gray)
                                       .foregroundColor(selectedCategory?.id == category.id ? Color.black : Color.white)
                                       .cornerRadius(30)
                               }
                           }
                       }
                       .padding()
                   }
                   
                   // Subcategory view for selected category
                   if let category = selectedCategory {
                       VStack(alignment: .leading, spacing: 20) {
                           ForEach(category.subcategories) { subcategory in
                               ZStack {
                                   Image(subcategory.image)
                                       .resizable()
                                       .frame(maxWidth: .infinity, maxHeight: 480)
                                       .cornerRadius(40)
                                   
                                   VStack(alignment: .leading) {
                                       ZStack {
                                           blur22()
                                           Text(subcategory.title)
                                               .font(.headline)
                                               .foregroundColor(.white)
                                       }
                                       Spacer()
                                       
                                       HStack {
                                           Text(subcategory.duration)
                                               .font(.system(size: 30, weight: .bold))
                                               .foregroundColor(.white)
                                           
                                           Spacer()
                                           
                                           Button(action: {
                                               openLink(url: subcategory.link)
                                           }) {
                                               ZStack {
                                                   blur23()
                                                   Image(systemName: "chevron.right")
                                                       .font(.system(size: 18, weight: .bold))
                                                       .foregroundColor(.white)
                                               }
                                           }
                                       }
                                       .padding(.leading)
                                   }
                                   .padding()
                               }
                               .cornerRadius(10)
                               .shadow(radius: 5)
                           }
                       }
                       .padding()
                   } else {
                       // Placeholder view before selecting a category
                       Text("Choose a category to see details")
                           .font(.title)
                           .foregroundColor(.white)
                           .padding()
                   }
                   Spacer()
               }
           }
       }
       
       func openLink(url: String) {
           guard let link = URL(string: url) else { return }
           UIApplication.shared.open(link)
       }
    }


/*
#Preview {
        MainView()
}
*/




