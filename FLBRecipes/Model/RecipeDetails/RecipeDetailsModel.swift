//
//  RecipeDetailsModel.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-17.
//

import Foundation

struct RecipeDetailsModel {
    
    let id: Int
    let imageUrl: String
    let title: String
    let summary: String
    
}

extension RecipeDetailsModel {
    init(from recipe: RecipeDetails) {
        self.id = recipe.id
        self.title = recipe.title
        self.imageUrl = recipe.image
        self.summary = recipe.summary
        //        self.imageURL = URL(string: recipe.image) ?? URL(string: "https://example.com/fallback.jpg")!
    }
    
}
