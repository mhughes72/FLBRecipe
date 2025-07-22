//
//  IngredientListTableController.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-18.
//

import UIKit

class IngredientListTableController: UITableViewController {
    var missedIngredients: [Int: [String]] = [:]
//    let apiKey: String
    
    var ingredientListManager = IngredientListManager()
    var recipesListArray: [IngredientListModel] = []
//    let ingredients = "Hot sauces, mustard, ketchup, miso paste, salsa, organic applesauce, whipped cream, pesto, raspberry preserves, assorted cheeses, tofu, butter, pickles, various packaged meats, leafy greens, squash soup, sliced mushrooms, egg carton, club soda, bottled beverages, soy milk."
    
    let ingredients = "San Pellegrino, milk, eggs, half & half, oat milk, hummus, carrots, cucumber, grapes, apples, citrus fruits, lemons, limes, avocados, bell peppers, peach cups, applesauce, blueberries, strawberries, string cheese, yogurt, cheese, turkey breast"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    
        ingredientListManager.delegate = self
        ingredientListManager.fetchRecipe(ingredients: ingredients)
        tableView.rowHeight = 100.0
        
        //GPT IMAGE REQ
//        if let myImage = UIImage(named: "fridge05") {
//            analyzeImageWithChatGPT(myImage, ingredientListManager: ingredientListManager)
//        }
//        
        
        //GPT TEXT REQ
//        fetchGPTResponse(prompt: "What's the capital of France?") { response in
//            DispatchQueue.main.async {
//                print("GPT says: \(response ?? "No response")")
//            }
//        }
        
        
        
    }

    // MARK: - Table view data source


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        print(recipesListArray.count)
        return recipesListArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        
        
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "IngredientListCell", for: indexPath) as! IngredientListTableCell

        let recipe = recipesListArray[indexPath.row]
        
        
        missedIngredients[recipe.id] = []
        
        
        for ingredient in recipe.missedIngredients {
            missedIngredients[recipe.id]?.append("\(ingredient.originalName)")
//            print("missing: \(i.originalName)")

        }

        
//        print("recipe: \(recipe.missedIngredients.originalName)")
//        print("missedIngredients \(missedIngredients)")
        cell.ingredientNameLabel.text = ("\(recipe.id)")
        cell.usedIngredientsLabel.text = String(recipe.usedIngredientCount) + " USED"
        cell.missedIngredientsLabel.text = String(recipe.missedIngredientCount) + "MISSING"

        if let url = URL(string: recipe.imageUrl) {
            cell.ingredientImageView.kf.setImage(
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
                        cell.ingredientImageView.image = UIImage(systemName: "exclamationmark.triangle") // SF Symbol on failure
                    }
                })
        } else {
            cell.ingredientImageView.image = UIImage(named: "fallback") // Use fallback for invalid URL
        }

        return cell

    }

    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // showRecipeDetails
        print("Button Clicked: \(missedIngredients)")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             tableView.deselectRow(at: indexPath, animated: true)
         }
        
        performSegue(withIdentifier: "showRecipeDetails", sender: self)
        

    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetails",
           let destinationVC = segue.destination as? RecipeDetailsViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedRecipeId = recipesListArray[indexPath.row].id
            destinationVC.missedIngredients = missedIngredients
            destinationVC.recipeId = selectedRecipeId
        }
    }
    
}


extension IngredientListTableController: IngredientListManagerDelegate {
    func didUpdateRecipe(_ ingredientListManager: IngredientListManager, recipes: [IngredientListModel]) {
        recipesListArray = recipes
        
        for rec in recipes {
//            print("\rRecipe: \(rec.title)\r")
//            missedIngredients
            missedIngredients[rec.id] = []
            for r in rec.missedIngredients {
                missedIngredients[rec.id]?.append(r.originalName)
//                missedIngredients[rec.id] = r.originalName
//                print("\(r.originalName)\r")
            }
        }
//        print("missed: \(missedIngredients)")
        
//        for ing in recipes.missedIngredients {
//            print("MISS: NAME - \(recipe.title) -> \(ing.originalName)\r\r")
//            missedIngredients[recipe.id] = ing.originalName
////            print(ing.originalName)
//        }
        
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print("didFailWithError2 \(error)")
    }
    
    
}
