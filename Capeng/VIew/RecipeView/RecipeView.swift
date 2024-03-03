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
                        NavigationLink(destination: RecipeDetailView(recipe: recipe)) { // 여기에 recipe 객체를 전달
                            Text(recipe.recipeName ?? "Unknown Recipe")
                        }
                    }
                    .onDelete(perform: deleteRecipes)
                }

                .navigationBarTitle("Recipes")
                .navigationBarItems(trailing: NavigationLink(destination: RecipeDetailView()) {
                    Image(systemName: "plus")
                })
            }
        }

    }

    private func deleteRecipes(offsets: IndexSet) {
        withAnimation {
            offsets.map { recipes[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // 오류 처리
                print(error.localizedDescription)
            }
        }
    }

}


struct RecipeView_Previews: PreviewProvider {
    static var previews: some View {
        RecipeView()
    }
}













