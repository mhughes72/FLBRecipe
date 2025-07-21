//
//  IngredientListData.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-18.
//

import Foundation

// Actual data from API


struct IngredientListData: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String?
    let usedIngredientCount: Int
    let missedIngredientCount: Int
    let likes: Int?
    let missedIngredients: [Ingredient]
    let usedIngredients: [Ingredient]
    let unusedIngredients: [Ingredient]
}

struct Ingredient: Codable {
    let id: Int
    let amount: Double
    let unit: String
    let unitLong: String
    let unitShort: String
    let aisle: String
    let name: String
    let original: String
    let originalName: String
    let meta: [String]
    let image: String
}
