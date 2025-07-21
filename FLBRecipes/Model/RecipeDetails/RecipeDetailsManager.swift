//
//  RecipeDetailsManager.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-17.
//

import Foundation
// https://api.spoonacular.com/recipes/452116/information?apiKey=bfbc9b8762b24be08d0f2bcd99da68bd

protocol RecipeDetailsManagerDelegate {
    func didUpdateRecipe(_ recipeDetailsManager: RecipeDetailsManager, recipe: RecipeDetailsModel)
    func didFailWithError(error: Error)
}


struct RecipeDetailsManager {
    
    
    let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String

    let recipeURL = "https://api.spoonacular.com/recipes/"

    var delegate: RecipeDetailsManagerDelegate?
    
    func fetchRecipe(recipeId: Int) {
        
        if let apiKey = Bundle.main.infoDictionary?["API_KEY"] as? String {
            print("apiKey: \(apiKey)")
            var components = URLComponents()
            components.scheme = "https"
            components.host = "api.spoonacular.com"
            components.path = "/recipes/\(recipeId)/information"
            components.queryItems = [
//                URLQueryItem(name: "recipeId", value: ("\(recipeId)")),
                URLQueryItem(name: "apiKey", value: apiKey)
            ]
//            print("components: \(components.url)")

            if let url = components.url {
                performRequest(with: url)
                print("url 666: \(url)")
            }
        }
        
//        let urlString = "\(recipeURL)\(recipeId)/information?apiKey=\(String(describing: apiKey))"
//        print (urlString)
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

                    if let recipe = self.parseJSON(safeData) {
                        self.delegate?.didUpdateRecipe(self, recipe: recipe)

                      
                    }
                }
            }
            task.resume()
        
    }
    
    func parseJSON(_ data: Data) -> RecipeDetailsModel? {
        let decoder = JSONDecoder()
        
        do {
            let decodedData = try decoder.decode(RecipeDetails.self, from: data)
//            let models = decodedData.results.map { RecipeDetailsModel(from: $0) }
            let models = RecipeDetailsModel(from: decodedData)

            
            return models
        } catch {
            delegate?.didFailWithError(error: error)
            return nil
        }
    }

 
}
