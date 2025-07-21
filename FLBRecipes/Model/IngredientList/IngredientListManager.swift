//
//  IngredientListManager.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-18.
//

import Foundation

protocol IngredientListManagerDelegate {
    func didUpdateRecipe(_ ingredientListManager: IngredientListManager, recipes: [IngredientListModel])
    func didFailWithError(error: Error)
}

struct IngredientListManager {
    
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String

    let recipeURL = "https://api.spoonacular.com/recipes/"
//    let ingredients = "Celery, cucumbers, kale, starfruit, limes, lemons, green bell pepper, avocados, carrots, radishes, beets, peaches, apples, oranges, fermented vegetables (in jars), sweet potatoes, pickled red cabbage, kombucha, probiotic drinks, cherry tomatoes, fresh herbs (parsley, cilantro), sauerkraut, supplements (in jars), mixed nuts or granola (in jars), turmeric root (in jar), zucchini"
// /*   let ingredients = "Arugula, avocados, herbs, sauerkraut, matcha, supplements, turmeric roots, pickled vegetables, fermented foods, cucumbers, kale, green bell pepper, limes, lemons, */starfruit, kombucha, juices, radishes, carrots, sweet potatoes, apples, oranges, peaches."
//    let ingredients = "carrots,chicken,bread"
//    let ingredients = "Hot sauces, mustard, ketchup, miso paste, salsa, organic applesauce, whipped cream, pesto, raspberry preserves, assorted cheeses, tofu, butter, pickles, various packaged meats, leafy greens, squash soup, sliced mushrooms, egg carton, club soda, bottled beverages, soy milk."
    
    
    var delegate: IngredientListManagerDelegate?
    
    func encodeString(_ nonencoded: String) -> String? {
        return nonencoded.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)
    }
        
    func fetchRecipe(ingredients: String) {
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.spoonacular.com"
            components.path = "/recipes/findByIngredients"
            components.queryItems = [
                URLQueryItem(name: "ingredients", value: ingredients),
                URLQueryItem(name: "apiKey", value: apiKey)
            ]

            if let url = components.url {
                performRequest(with: url)
            }
        }
//        let urlString = "\(recipeURL)findByIngredients?ingredients=\(String(describing: ingredients))&apiKey=\(apiKey)"
//        print("apiKey: \(String(describing: apiKey))")
//        print("urlString \(urlString)")
//        performRequest(with: urlString)
    }
    
    
    func performRequest(with url: URL) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {
                    if let ingredientList = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRecipe(self, recipes: ingredientList)
                    }
                }
            }
            task.resume()
        
    }
    
    func parseJSON(_ data: Data) -> [IngredientListModel]? {
        let decoder = JSONDecoder()
        print(data)
        do {
            let decodedData = try decoder.decode([IngredientListData].self, from: data)
            let models = decodedData.map { IngredientListModel(from: $0) }
            return models
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }
    
}
