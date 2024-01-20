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
            WeatherView()
                .tabItem {
                    Image(systemName: "cloud.sun.fill")
                    Text("날씨")
                }

            RecipeView()
                .tabItem {
                    Image(systemName: "cup.and.saucer.fill")
                    Text("레시피")
                }

            CafeReviewView()
                .tabItem {
                    Image(systemName: "list.clipboard")
                    Text("카페 다이어리")
                }
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


