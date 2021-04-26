//
//  RecipeTableViewCell.swift
//  MyRecipe
//
//  Created by chia on 2021/4/20.
//

import UIKit

class RecipeTableViewCell: UITableViewCell {
    @IBOutlet weak var imageFood: UIImageView!
    @IBOutlet weak var FoodName: UILabel!
    @IBOutlet weak var FoodType: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
