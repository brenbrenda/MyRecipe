//
//  StarViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/5/4.
//

import UIKit

class SearchViewController: UIViewController {

    let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        table.rowHeight = 270
        return table
    }()
    let searchBar: UISearchBar = {
        let searchBar = UISearchBar()
        return searchBar
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTable()
        setupSearchBar()
        

        // Do any additional setup after loading the view.
    }
    func setupSearchBar() {
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
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = table.dequeueReusableCell(withIdentifier: "cell")!
        return cell
    }
    
    
}

class SearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
