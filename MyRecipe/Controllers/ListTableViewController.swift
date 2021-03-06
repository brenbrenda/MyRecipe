//
//  ListTableViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/3/22.
//

import UIKit

class ListTableViewController: UITableViewController {

    let Menu = ["lunch","main dish","dinner","dessert"]
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        title = "RECIPE"
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return Menu.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! MenuTableViewCell
        cell.MenuLabel?.text = Menu[indexPath.row]
        return cell
    }
    
    @IBSegueAction func CategoryRecipe(_ coder: NSCoder) -> RecipeTableViewController? {
        guard let selectedMenu = tableView.indexPathForSelectedRow else { return nil }
        return RecipeTableViewController(coder: coder, Menu: Menu[selectedMenu.row])
    }
}
