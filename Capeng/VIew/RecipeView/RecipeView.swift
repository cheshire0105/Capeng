//
//  RecipeView.swift
//  Capeng
//
//  Created by cheshire on 1/20/24.
//

import Foundation
import SwiftUI
import CoreData

struct RecipeView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @FetchRequest(
           sortDescriptors: [NSSortDescriptor(keyPath: \Recipe.recipeName, ascending: true)],
           animation: .default)
       private var recipes: FetchedResults<Recipe>


    var body: some View {
        NavigationView {
            ZStack {
                Color("BackGroundColor").edgesIgnoringSafeArea(.all)

                List {
                    ForEach(recipes) { recipe in
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) {
                            Text(recipe.recipeName ?? "Unknown Recipe")
                        }
                    }
                }
                .navigationBarTitle("Recipes")
                .navigationBarItems(trailing: NavigationLink(destination: RecipeDetailView()) {
                    Image(systemName: "plus")
                })
            }
        }

    }
}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}













