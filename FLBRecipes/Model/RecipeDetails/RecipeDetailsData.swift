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
    
}


