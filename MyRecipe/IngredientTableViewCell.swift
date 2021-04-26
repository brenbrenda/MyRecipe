//
//  IngredientTableViewCell.swift
//  MyRecipe
//
//  Created by chia on 2021/4/21.
//

import UIKit

class IngredientTableViewCell: UITableViewCell {

    @IBOutlet weak var addButton: UIButton!
    @IBOutlet weak var foodLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func AddButtonIndex(_ sender: UIButton) {
    }
    
}
