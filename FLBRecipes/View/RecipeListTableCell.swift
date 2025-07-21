//
//  RecipeTableViewCell.swift
//  FLBRecipes
//
//  Created by Matt Hughes on 2025-07-16.
//

import UIKit

class RecipeListTableCell: UITableViewCell {
    
    @IBOutlet weak var recipeImageView: UIImageView!
    @IBOutlet weak var recipeNameLabel: UILabel!
    
    
    
       override func awakeFromNib() {
           super.awakeFromNib()
           // Optional: Customize appearance
           recipeImageView.contentMode = .scaleAspectFill
           recipeImageView.clipsToBounds = true
       }

       override func prepareForReuse() {
           super.prepareForReuse()
           // Reset the image and text for reuse
           recipeImageView.image = nil
           recipeNameLabel.text = ""
       }
}
