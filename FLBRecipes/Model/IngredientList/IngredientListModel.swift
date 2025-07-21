//
//  IngredientListModel.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-18.
//

import Foundation

struct IngredientListModel {
    
    let id: Int
    let imageUrl: String
    let title: String
    let usedIngredientCount: Int
    let missedIngredientCount: Int
    let missedIngredients: [Ingredient]
}

extension IngredientListModel {
    init(from recipe: IngredientListData) {
        self.id = recipe.id
        self.title = recipe.title
        self.imageUrl = recipe.image
        self.usedIngredientCount = recipe.usedIngredientCount
        self.missedIngredientCount = recipe.missedIngredientCount
        self.missedIngredients = recipe.missedIngredients
        //        self.imageURL = URL(string: recipe.image) ?? URL(string: "https://example.com/fallback.jpg")!
    }
    
}

