//
//  RecipeListManager.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-16.
//

import Foundation


protocol RecipeListManagerDelegate {
    func didUpdateRecipe(_ recipeListManager: RecipeListManager, recipes: [RecipeListModel])
    func didFailWithError(error: Error)
}


struct RecipeListManager {
    
// FIX how url is formed like in ingredientlist and recipedetail
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String

//    let query = "pasta"
    let recipeURL = "https://api.spoonacular.com/recipes/complexSearch"
    
    var delegate: RecipeListManagerDelegate?
    
    func fetchRecipe(cuisine: String) {
        let urlString = "\(recipeURL)?query=\(cuisine)&apiKey=\(String(describing: apiKey))"
//        let urlString = "\(recipeURL)/recipes/findByIngredients?ingredients=\(cuisine)&apiKey=\(apiKey)"
//        let urlString = "https://api.spoonacular.com/recipes/findByIngredients?ingredients=apples,beef,cream&apiKey=bfbc9b8762b24be08d0f2bcd99da68bd"
        print("URL: \(urlString)")
        performRequest(with: urlString)
    }
    
    
    func performRequest(with urlString: String) {
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) { (data, response, error) in
                if error != nil {
                    self.delegate?.didFailWithError(error: error!)
                    return
                }
                if let safeData = data {

                    if let recipes = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRecipe(self, recipes: recipes)

                      
                    }
                }
            }
            task.resume()
        }
    }
    
    func parseJSON(_ data: Data) -> [RecipeListModel]? {
        
        
        
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(RecipeListResponse.self, from: data)
            let models = decodedData.results.map { RecipeListModel(from: $0) }
            return models
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

 
}
