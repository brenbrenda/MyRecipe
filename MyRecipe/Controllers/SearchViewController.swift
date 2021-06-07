//
//  SearchViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/5/4.
//

import UIKit
protocol SearchControllerDelegate {
    func didStartSearching()
    func didTapOnSearchButton()
    func didTapOnCancelButton()
    func didChangeSearchText(searchText: String)
}
class SearchViewController: UIViewController {

    var customDelegate: SearchControllerDelegate!
    let table: UITableView = {
        let table = UITableView()
        table.register(SearchTableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = 270
        return table
    }()
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
//        searchBar.isSearchResultsButtonSelected = true
        searchBar.searchBarStyle = .minimal
//        searchBar.showsSearchResultsButton = true
//        searchBar.showsScopeBar = true
        searchBar.showsBookmarkButton = true
        return searchBar
    }()
    
    var item = [RecipeDetail]()
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTable()
        setupSearchBar()
        // Do any additional setup after loading the view.
    }

//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        fetchdata()
//    }
   
    func setupSearchBar() {
        searchBar.delegate = self
        searchBar.barStyle = .black
        searchBar.backgroundColor = .purple
        searchBar.frame = CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 30)
        view.addSubview(searchBar)
        self.navigationItem.titleView = searchBar
    }
    func setupTable() {
        view.addSubview(table)
        table.frame = view.bounds
        table.dataSource = self
        table.delegate = self
    }

}

extension SearchViewController: UITableViewDataSource, UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        item.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = table.dequeueReusableCell(withIdentifier: "cell") as? SearchTableViewCell else { return UITableViewCell() }
        let items = item[indexPath.row]
        cell.item = items
        //cell.setupCell() //set the cell of image and title
        cell.FoodName.text = items.title
        if let itemsimage = items.image {
            fetchImage(url: itemsimage) {(image) in
                DispatchQueue.main.async {
                    cell.FoodImage.image = image
                }
            }
        }
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let selectRow = tableView.indexPathForSelectedRow?.row {
            let controller = SearchDetailViewController()
            navigationController?.pushViewController(controller, animated: true)
            controller.ingredient = item[selectRow].extendedIngredients
            controller.analyzedInstruction = item[selectRow].analyzedInstructions
        }
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
}
extension SearchViewController: UISearchBarDelegate, UISearchResultsUpdating, UISearchControllerDelegate {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
//        customDelegate.didTapOnSearchButton()
    }
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
//        customDelegate.didTapOnCancelButton()
    }
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//        fetchdata()
    }
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
//        customDelegate.didStartSearching()
        fetchdata()
       
    }
    func didStartSearching() {
//        fetchdata()
    }

    func fetchdata() {
        //https://api.spoonacular.com/recipes/complexSearch?apiKey=4ff9f759176f40fe807cfa4febdffa89&query=cucumber
        //https://api.spoonacular.com/recipes/random?apiKey=a78360c4350d403fa262100954ee9e1d&number=20&titleMatch=\(searchBar.text?.lowercased())
        guard let Str = "https://api.spoonacular.com/recipes/random?apiKey=a78360c4350d403fa262100954ee9e1d&number=30&tags=\(searchBar.text?.lowercased())".addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else { return }
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
                    self?.table.reloadData()
                   
                } catch {
//                    print(error)
                    let alert = UIAlertController(title: "Cannot Find Recipes", message: "Please enter another key word", preferredStyle: .alert)
                    alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                    self?.searchBar.text = ""
                    self?.present(alert, animated: true)
                    
                }
            }
        }.resume()
    }
}

