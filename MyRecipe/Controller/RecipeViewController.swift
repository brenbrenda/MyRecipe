//
//  RecipeViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/4/19.
//

import UIKit

class RecipeViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {

    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return table
    }()
//    var igData: IGData!
//    var igPosts = [IGData.Graphql.User.Edge_owner_to_timeline_media.Edges]()
//    var recipe: Recipe!
//    var result = [Recipe.Result]()
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        // Do any additional setup after loading the view.
    }
    

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
        
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        //result.count
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! RecipeTableViewCell
        //cell.textLabel?.text = result[indexPath.row].title
        //cell.textLabel?.largeContentImage = result[indexPath.row].image
        
        cell.textLabel?.font = UIFont(name: "Hiragino Mincho ProN", size: 20)
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
