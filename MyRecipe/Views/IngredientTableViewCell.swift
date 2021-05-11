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
        setupLayouts()
    }
    func setupLayouts() {
        foodLabel.translatesAutoresizingMaskIntoConstraints = false
        foodLabel.numberOfLines = 0
        foodLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        foodLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 3).isActive = true
        foodLabel.trailingAnchor.constraint(equalTo: addButton.leadingAnchor, constant: -10).isActive = true
        foodLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
