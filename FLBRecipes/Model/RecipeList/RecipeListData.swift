//
//  RecipeData.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-16.
//

import Foundation

// Actual data from API
struct RecipeListResponse: Codable {
    let results: [RecipeList]
    let offset: Int
    let number: Int
    let totalResults: Int
}

struct RecipeList: Codable {
    let id: Int
    let title: String
    let image: String
    let imageType: String
}

//struct Main: Codable {
//    let temp: Double
//}
//
//struct Weather: Codable {
//    let description: String
//    let id: Int
//}
