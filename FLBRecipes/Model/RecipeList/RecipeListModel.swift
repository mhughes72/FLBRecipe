//
//  RecipeModel.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-16.
//

import Foundation

// Model the original data to make it better for UI
struct RecipeListModel {
    let id: Int
    let name: String
    let imageURL: String
}

extension RecipeListModel {
    init(from recipe: RecipeList) {
        self.id = recipe.id
        self.name = recipe.title
        self.imageURL = recipe.image
//        self.imageURL = URL(string: recipe.image) ?? URL(string: "https://example.com/fallback.jpg")!
    }
}
