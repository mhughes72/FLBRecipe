//
//  RecipeDetailsData.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-17.
//

import Foundation

// Actual data from API
struct RecipeDetails: Codable {
    
    let id: Int
    let image: String
    let title: String
    let summary: String
//    let missedIngredients: [Ingredient]
    
    let analyzedInstructions: [Steps]
    let extendedIngredients: [ExtendedIngredients]
}


struct ExtendedIngredients: Codable {
    let originalName: String
    let measures: Measures
}

struct Measures: Codable {
    let us, metric: MeasureDetail
}

struct MeasureDetail: Codable {
    let amount: Double
    let unitShort, unitLong: String
}

struct Steps: Codable {
    let steps: [OneStep]
}

struct OneStep: Codable {
    let number: Int
    let step: String
    let ingredients: [OneIngredient]
//    let equipment: [Equipment]
}

struct OneIngredient: Codable {
    let id: Int
    let name: String
    let localizedName: String
    let image: String
}




