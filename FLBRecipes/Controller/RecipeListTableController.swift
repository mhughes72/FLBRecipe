//
//  RecipeListTableController.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-16.
//

import UIKit
//import SDWebImage
import Kingfisher


class RecipeListTableController: UITableViewController {

    var recipeListManager = RecipeListManager()
    var recipesListArray: [RecipeListModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeListManager.delegate = self
        recipeListManager.fetchRecipe(cuisine: "italian")
        print("LOADED")
        tableView.rowHeight = 100.0
    }



    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        print("recipes.count \(recipesListArray.count)")
        return recipesListArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "RecipeListCell", for: indexPath) as! RecipeListTableCell

        let recipe = recipesListArray[indexPath.row]
        cell.recipeNameLabel.text = recipe.name

        if let url = URL(string: recipe.imageURL) {
            cell.recipeImageView.kf.setImage(
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
                        cell.recipeImageView.image = UIImage(systemName: "exclamationmark.triangle") // SF Symbol on failure
                    }
                })
        } else {
            cell.recipeImageView.image = UIImage(named: "fallback") // Use fallback for invalid URL
        }

        return cell

    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // showRecipeDetails
        print("Button Clicked")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0) {
             tableView.deselectRow(at: indexPath, animated: true)
         }
        
        performSegue(withIdentifier: "showRecipeDetails", sender: self)
        
        
////        let selectedCategory = categoryArray[indexPath.row]
//        performSegue(withIdentifier: "goToItems", sender: self)
//
//        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showRecipeDetails",
           let destinationVC = segue.destination as? RecipeDetailsViewController,
           let indexPath = tableView.indexPathForSelectedRow {
            
            let selectedRecipeId = recipesListArray[indexPath.row].id
            destinationVC.recipeId = selectedRecipeId
        }
    }

}

extension RecipeListTableController: RecipeListManagerDelegate {
    func didUpdateRecipe(_ recipeListManager: RecipeListManager, recipes: [RecipeListModel]) {
        print("didUpdateRecipe")
        print(recipes)
        recipesListArray = recipes
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func didFailWithError(error: any Error) {
        print("didFailWithError: \(error)")

    }
    
    
}
