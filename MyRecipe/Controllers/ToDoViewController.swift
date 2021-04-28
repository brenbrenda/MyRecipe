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

//    private let add: UIButton = {
//        let add = UIButton()
//        add.backgroundColor = .darkGray
//        add.target(forAction: #selector(itemadded), withSender: self)
//        //add.translatesAutoresizingMaskIntoConstraints = false
//        return add
//    }()
    var Selectrow: Int?
    override func viewDidLoad() {
        super.viewDidLoad()
        food = UserDefaults.standard.stringArray(forKey: "food") ?? []
        title = "List to BUY"
        view.addSubview(table)
        table.dataSource = self
        table.delegate = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(additem))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .edit, target: self, action: #selector(ChangeOrder))
        table.reloadData()
        

    }
    
    func tableView(_ tableView: UITableView, accessoryButtonTappedForRowWith indexPath: IndexPath) {
        /*guard let row = tableView.indexPathForSelectedRow?.row else { return nil }
         return LoverDetailViewController(coder: coder, lover: lovers[row])*/
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        Selectrow = tableView.indexPathForSelectedRow?.row
        let controller = noteController()
        navigationController?.pushViewController(controller, animated: true)
        if let Selectrow = Selectrow {
            controller.uneditInt = Selectrow
        }
    }


    @objc private func additem() {
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
//                        var currentFood = UserDefaults.standard.stringArray(forKey: "food") ?? []
                        currentFood.append(text)
                        UserDefaults.standard.setValue(currentFood, forKey: "food")
                        food.append(text)
                        print(food)
                        table.reloadData()
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
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(true)
        table.reloadData()
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
            UserDefaults.standard.setValue(currentFood, forKey: "food")//add
            table.reloadData()
            print(food)
            print(currentFood)
        }
    }
}
class noteController: UIViewController {
    lazy var Note: UITextView = {
        let Note = UITextView()
//        Note.translatesAutoresizingMaskIntoConstraints = false
        Note.textAlignment = .natural
        Note.isEditable = true
        Note.isScrollEnabled = false
        return Note
    }()
    var uneditInt: Int = 0
    var editedtext: String = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(Note)
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .save, target: self, action: #selector(save))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(cancel))

        Note.frame = view.bounds
        setupNote()
    }

    func setupNote() {
        Note.text = food[uneditInt]
        Note.font = UIFont(name: "Hiragino Mincho ProN", size: 25)
//        Note.backgroundColor = .blue
//        Note.topAnchor.constraint(equalTo: view.topAnchor, constant: 10).isActive = true
//        Note.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 10).isActive = true
//        Note.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10).isActive = true
//        Note.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10).isActive = true
    }
    @objc func save() {
        editedtext = Note.text
        print(editedtext)
        currentFood[uneditInt] = editedtext
        UserDefaults.standard.setValue(currentFood, forKey: "food")
        food[uneditInt] = editedtext
        print(food)
        print(currentFood)
        self.navigationController?.popToRootViewController(animated: true)
    }
    @objc func cancel() {
        self.navigationController?.popToRootViewController(animated: true)
    }
}
