//
//  SearchTableViewCell.swift
//  MyRecipe
//
//  Created by chia on 2021/5/6.
//

import UIKit

class SearchTableViewCell: UITableViewCell {
    var item: RecipeDetail!
    var FoodName: UILabel = {
        let FoodName = UILabel()
        FoodName.backgroundColor = .gray
        FoodName.translatesAutoresizingMaskIntoConstraints = false
        FoodName.textAlignment = .center
        FoodName.font = UIFont(name: "Hiragino Mincho ProN", size: 20)
        FoodName.numberOfLines = 0
        return FoodName
    }()
    var FoodImage: UIImageView = {
        let FoodImage = UIImageView()
        FoodImage.backgroundColor = .purple
        FoodImage.translatesAutoresizingMaskIntoConstraints = false
        FoodImage.contentMode = .scaleAspectFill
        return FoodImage
    }()
    override func awakeFromNib() {
        super.awakeFromNib()
//        FoodName.frame = CGRect(x: 0, y: 100, width: UIScreen.main.bounds.width, height: 10)
//        FoodImage.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20 , height: 260)
//        addSubview(FoodName)
//        addSubview(FoodImage)
       // setupLayout()
    }
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        //FoodName.frame = CGRect(x: 0, y: 0, width: 300, height: 50)
        FoodImage.frame = CGRect(x: 10, y: 10, width: UIScreen.main.bounds.width - 20, height: UIScreen.main.bounds.height - 20)

        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupLayout() {
        let cellView = UIView()
        addSubview(cellView)
        cellView.translatesAutoresizingMaskIntoConstraints = false
        cellView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cellView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        cellView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellView.topAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellView.backgroundColor = .blue
       
        addSubview(FoodName)
        
        FoodName.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        FoodName.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        FoodName.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
//        FoodName.topAnchor.constraint(equalTo: topAnchor, constant: 150).isActive = true
        cellView.addSubview(FoodImage)
        FoodImage.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        FoodImage.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        FoodImage.topAnchor.constraint(equalTo: topAnchor).isActive = true
        FoodImage.bottomAnchor.constraint(equalTo: FoodName.topAnchor).isActive = true
       
    }
    func setupCell() {
        if let itemimage = item.image {
            fetchImage(url: itemimage) {(image) in
                DispatchQueue.main.async {
                    self.FoodImage.image = image
                }
            }
        }
        FoodName.text = item.title
    }
    func fetchImage(url: URL, completion: @escaping(UIImage?) -> Void) {
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let data = data, let image = UIImage(data: data) {
                completion(image)
                
            } else {
                completion(nil)
            }
            
        }.resume()
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
}
