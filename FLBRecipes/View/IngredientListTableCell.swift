//
//  IngredientListTableCell.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-18.
//

import UIKit

class IngredientListTableCell: UITableViewCell {

    
    @IBOutlet weak var ingredientImageView: UIImageView!
    @IBOutlet weak var ingredientNameLabel: UILabel!
         
    @IBOutlet weak var missedIngredientsLabel: UILabel!
    
    @IBOutlet weak var usedIngredientsLabel: UILabel!
    
    //    @IBOutlet weak var missedIngredientsLabel: UILabel!
    //    @IBOutlet weak var usedIngredientsLabel: UILabel!
    
    //    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Optional: Customize appearance
//        recipeImageView.contentMode = .scaleAspectFill
//        recipeImageView.clipsToBounds = true
//    }
//
//    override func prepareForReuse() {
//        super.prepareForReuse()
//        // Reset the image and text for reuse
//        recipeImageView.image = nil
//        recipeNameLabel.text = ""
//    }

}
