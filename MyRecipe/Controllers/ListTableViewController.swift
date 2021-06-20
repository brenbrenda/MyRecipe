//
//  ListTableViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/3/22.
//

import UIKit

class ListTableViewController: UITableViewController {

    @IBOutlet weak var search: UISearchBar!
    let Menu = ["lunch","main dish","dinner","dessert"]
    var item = [RecipeDetail]()
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "RECIPE"
        navigationController?.isNavigationBarHidden = true
//        tableView.rowHeight = (UIScreen.main.bounds.height - 10) / 4
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.isNavigationBarHidden = false
    }
    
    // MARK: - Table view data source

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        // #warning Incomplete implementation, return the number of sections
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        Menu.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        cell.MenuLabel?.text = Menu[indexPath.row]
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        (UIScreen.main.bounds.height - 200) / 4
    }
    
    @IBSegueAction func CategoryRecipe(_ coder: NSCoder) -> RecipeTableViewController? {
        guard let selectedMenu = tableView.indexPathForSelectedRow else { return nil }
        return RecipeTableViewController(coder: coder, Menu: Menu[selectedMenu.row])
      
    }
}
