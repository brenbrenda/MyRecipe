//
//  RecipeTableViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/4/19.
//

import UIKit

class RecipeTableViewController: UITableViewController {

    @IBOutlet weak var activity: UIActivityIndicatorView!
    var Menu :String
    init?(coder: NSCoder, Menu: String) { //coder 以及欲傳的資料
        self.Menu = Menu
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    var item = [RecipeDetail]()

    func fetchdata() {
        guard let Str = "https://api.spoonacular.com/recipes/random?apiKey=4ff9f759176f40fe807cfa4febdffa89&number=20&tags=\(Menu)".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
        guard let url = URL(string: Str) else {
            print("invalidURL")
            return
        }
        URLSession.shared.dataTask(with: url) {data, response, error in
            DispatchQueue.main.async { [weak self] in
                guard error == nil else {
                    print("Failed request:\(error)")
                    return
                }
                guard let data = data else {
                    print("No data returned")
                    return
                }
                do {
//                    print(String(data: data, encoding: .utf8))
                    let decoder = JSONDecoder()
                    let category = try decoder.decode(RecipeCate.self, from: data)
                    self?.item = category.recipes
                    self?.tableView.reloadData()
                    self?.activity.removeFromSuperview()
                } catch {
                    print(error)
                }
            }
        }.resume()
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchdata()
        title = Menu
        if let activity = activity{
            activity.isHidden = false
            activity.startAnimating()
        }
       
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return item.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeTableViewCell
        let items = item[indexPath.row]
        //let setcellFont = UIFont(name: "Hiragino Mincho ProN", size: 22)
        //cell.FoodName.font = setcellFont
        //cell.FoodType.font = setcellFont
        cell.FoodName.text = items.title
        //cell.FoodType.text = items.nutrition.nutrients[0].title
        cell.imageFood.image = UIImage(systemName: "rays")
        if let itemsimage = items.image {
            URLSession.shared.dataTask(with: itemsimage) { data, response, error in
                    if let data = data, let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.imageFood.contentMode = .scaleAspectFill
                            cell.imageFood.image = image
                        }
                    }
            }.resume() }
//        } else {
//            cell.imageFood.image = UIImage(systemName: "nosign")
//            cell.imageFood.contentMode = .scaleAspectFit
//            cell.FoodName.textColor = .black
//        }
        return cell
    }

    @IBSegueAction func SeeRecipe(_ coder: NSCoder) -> UIViewController? {
        guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
        return RecipeDetailViewController(coder: coder, item: item[row])
    }

}
