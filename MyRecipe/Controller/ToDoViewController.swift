//
//  ToDoViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/4/14.
//
var food = [String]()
var currentFood = UserDefaults.standard.stringArray(forKey: "food") ?? []
let table: UITableView = {
    let table = UITableView()
    table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    return table
}()
import UIKit

class ToDoViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {


    private let itemview: UIView = {
        let itemview = UIView()
        //itemview.translatesAutoresizingMaskIntoConstraints = false
        itemview.backgroundColor = .purple
        return itemview
    }()
    private let enterItem: UITextField = {
        let enterItem = UITextField()
        enterItem.backgroundColor = .white
        //enterItem.translatesAutoresizingMaskIntoConstraints = false
        return enterItem
    }()
    private let add: UIButton = {
        let add = UIButton()
        add.backgroundColor = .darkGray
        add.target(forAction: #selector(itemadded), withSender: self)
        //add.translatesAutoresizingMaskIntoConstraints = false
        return add
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        food = UserDefaults.standard.stringArray(forKey: "food") ?? []
        title = "List to BUY"
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(additem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ChangeOrder))
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Save", style: .plain, target: nil, action: nil)
        table.reloadData()

    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        /*guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
         return LoverDetailViewController(coder: coder, lover: lovers[row])*/
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let controller = noteController()
        navigationController?.pushViewController(controller, animated: true)
    }


    @objc private func additem() {
//        self.view.addSubview(itemview)
//        itemview.frame = CGRect(x: 50, y: 100, width: 250, height: 200)
//        itemview.center = self.view.center
        //itemview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        //itemview.topAnchor.constraint(equalTo: view.topAnchor, constant: 300).isActive = true
        //itemview.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        
            
        //itemview.addSubview(enterItem)沒顯示可能是因為button沒有大ㄍ
        //itemview.addSubview(add)
        let alert = UIAlertController(title: "New Ingredient", message: "", preferredStyle: .alert)
        alert.addTextField { field in
            field.placeholder = "Enter Food..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak self]
            (_) in
            if let field = alert.textFields?.first{
                if let text = field.text, !text.isEmpty {
                    
                    DispatchQueue.main.async {
                        var currentFood = UserDefaults.standard.stringArray(forKey: "food") ?? []
                        currentFood.append(text)
                        UserDefaults.standard.setValue(currentFood, forKey: "food")
                        food.append(text)
                        print(food)
                        table.reloadData()
                        print(food as Any)
                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    @objc func ChangeOrder() {
        if table.isEditing {
            table.isEditing = false
        } else {
            table.isEditing = true
        }
    }
    @objc private func itemadded() {
        animatedOut()

    }

    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return food.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = food[indexPath.row]
        
        cell.textLabel?.font = UIFont(name: "Hiragino Mincho ProN", size: 20)
        return cell
    }
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        food.swapAt(sourceIndexPath.row, destinationIndexPath.row)
        
    }
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            currentFood.remove(at: indexPath.row)
            UserDefaults.standard.removeObject(forKey: "food")
            food.remove(at: indexPath.item)
            tableView.deleteRows(at: [indexPath], with: .fade)
            table.reloadData()
            print(food)
            print(currentFood)
        }
    }

    func animatedIn() {
        self.view.addSubview(itemview)
        self.itemview.addSubview(enterItem)
        self.itemview.addSubview(add)
        itemview.frame = CGRect(x: 50, y: 100, width: 250, height: 200)
        itemview.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        itemview.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        itemview.transform = CGAffineTransform.init(scaleX: 2, y: 2)
        itemview.alpha = 0
        
        UIView.animate(withDuration: 0.3) {
            self.itemview.alpha = 1
            self.itemview.transform = CGAffineTransform.identity
            
        }
    }
    
    func animatedOut() {
        UIView.animate(withDuration: 0.3, animations: {
            self.itemview.transform = CGAffineTransform.init(scaleX: 2, y: 2)
            self.itemview.alpha = 0
        }) { (success: Bool) in
            self.itemview.removeFromSuperview()
        }
    }
    
    class noteController: UIViewController {
        private let Note: UILabel = {
            let Note = UILabel()
            return Note
        }()
        override func viewDidLoad() {
            super.viewDidLoad()
        }
        //view.backgr
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
