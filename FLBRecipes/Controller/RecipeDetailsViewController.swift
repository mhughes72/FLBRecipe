//
//  RecipeDetailsViewController.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-17.
//

import UIKit

class RecipeDetailsViewController: UIViewController {

    
    @IBOutlet weak var recipeDetailTitle: UILabel!
    @IBOutlet weak var recipeDetailImage: UIImageView!
    
    @IBOutlet weak var recipeDetailSummary: UILabel!
    
    @IBOutlet weak var recipeIngredients: UILabel!
    @IBOutlet weak var recipeDetailMissing: UILabel!
    @IBOutlet weak var recipeInstructions: UILabel!
    var recipeId: Int?
    var missedIngredients: [Int: [String]]?
    var recipeDetailsManager = RecipeDetailsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // TAKE OUT FOR FULL FUNCTIONALLITY
        recipeId = 643789
        
        recipeDetailsManager.delegate = self
        recipeDetailsManager.fetchRecipe(recipeId: recipeId!)
//        tableView.rowHeight = 100.0
    }

}

extension RecipeDetailsViewController: RecipeDetailsManagerDelegate {
    func didUpdateRecipe(_ recipeDetailsManager: RecipeDetailsManager, recipe: RecipeDetailsModel) {

        
        var recipeInstructions: String = ""
        for step in recipe.analyzedInstructions[0].steps {

            recipeInstructions += ("\(step.number): ")
            recipeInstructions += step.step + "\n\n"
        }
        
        var ingredients: String = ""
        for ingredient in recipe.extendedIngredients {

            ingredients += ("\(ingredient.measures.us.amount) ")
            ingredients += ingredient.measures.us.unitShort + " "
            ingredients += ingredient.originalName + "\n"
            
        }
        
        
        DispatchQueue.main.async {
            
            //TEMP Capitalize the contents
            self.missedIngredients = [643789: ["mushrooms", "onions", "beef", "soy sauce", "heavy cream"]]
                                             
            self.recipeDetailTitle.text = recipe.title

            self.recipeInstructions.text = "Instructions: \n"
            self.recipeDetailMissing.text = self.missedIngredients?[recipe.id]?.joined(separator: " | ")
            
            self.recipeInstructions.text =  recipeInstructions

            self.recipeIngredients.text = ingredients

            

        if let url = URL(string: recipe.imageUrl) {
            self.recipeDetailImage.kf.setImage(
                with: url,
                placeholder: UIImage(named: "placeholder"),
                options: [
                    .scaleFactor(UIScreen.main.scale),
                    .transition(.fade(0.3)),
                    .cacheOriginalImage
                ],
                completionHandler: { result in
                    switch result {
                    case .success:
                        break // Loaded successfully
                    case .failure:
                        self.recipeDetailImage.image = UIImage(systemName: "exclamationmark.triangle") // SF Symbol on failure
                    }
                })
        } else {
            self.recipeDetailImage.image = UIImage(named: "fallback") // Use fallback for invalid URL
        }

        }
    }
    
    func didFailWithError(error: any Error) {
        print("didFailWithError: \(error)")

    }
    
    
}
