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
    
    var recipeId: Int?
    var recipeDetailsManager = RecipeDetailsManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        recipeDetailsManager.delegate = self
        recipeDetailsManager.fetchRecipe(recipeId: recipeId!)
//        tableView.rowHeight = 100.0
    }

}

extension RecipeDetailsViewController: RecipeDetailsManagerDelegate {
    func didUpdateRecipe(_ recipeDetailsManager: RecipeDetailsManager, recipe: RecipeDetailsModel) {

        DispatchQueue.main.async {
            self.recipeDetailTitle.text = recipe.title

            
    
 

            self.recipeDetailSummary.text = recipe.summary
            self.recipeDetailSummary.numberOfLines = 0
            self.recipeDetailSummary.lineBreakMode = .byWordWrapping
            self.recipeDetailSummary.setNeedsLayout()
            self.recipeDetailSummary.layoutIfNeeded()
            

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
