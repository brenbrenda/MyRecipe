//
//  StepCell.swift
//  MyRecipe
//
//  Created by chia on 2021/4/23.
//

import UIKit

class StepCell: UICollectionViewCell {

    let foodTextView: UITextView = {
        
        let foodTextView = UITextView()
        foodTextView.font = UIFont(name: "Hiragino Mincho ProN", size: 20)
        foodTextView.translatesAutoresizingMaskIntoConstraints = false
        foodTextView.textAlignment = .center
        foodTextView.isEditable = false
        foodTextView.isScrollEnabled = false
        return foodTextView
    }()
    var IngreText: String! = "" {
        didSet{
            if let name = IngreText {
                foodTextView.text = name
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    private func setupLayout() {
        addSubview(foodTextView)
        foodTextView.topAnchor.constraint(equalTo: topAnchor, constant: 5).isActive = true
        foodTextView.leftAnchor.constraint(equalTo: leftAnchor, constant: 20).isActive = true
        foodTextView.rightAnchor.constraint(equalTo: rightAnchor, constant: -20).isActive = true
        foodTextView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 10).isActive = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
