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
    var isCheckHeart: Bool!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
       
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        isCheckHeart = false
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBAction func checkHeart(_ sender: UIButton) {
        let ischecked = !isCheckHeart
        if ischecked == true {
            sender.setImage(UIImage(systemName: "heart.fill"), for: .normal)
            isCheckHeart = true
        } else {
            sender.setImage(UIImage(systemName: "heart"), for: .normal)
            isCheckHeart = false
        }
    }
    
}
