//
//  ContentView.swift
//  Capeng
//
//  Created by cheshire on 1/18/24.
//

import SwiftUI

struct MainView: View {

    var body: some View {
        
        TabView {
//            WeatherView()
//                .tabItem {
//                    Image(systemName: "cloud.sun.fill")
//                    Text("Today")
//                }

            RecipeView()
                .tabItem {
                    Image(systemName: "cup.and.saucer.fill")
                    Text("Recipe")
                }

//            CafeReviewView()
//                .tabItem {
//                    Image(systemName: "list.clipboard")
//                    Text("Cafe Diary")
//                }
        }
        .background(Color("BackGroundColor"))
        .accentColor(Color("TabBarIconColor"))

    }
}



struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}


