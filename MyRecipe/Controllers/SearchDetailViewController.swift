//
//  SearchDetailViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/5/19.
//
import UIKit

class SearchDetailViewController: UIViewController, UITableViewDataSource, alerts {
    func presentAlert(title: String, message: String) {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true)
    }

    let FoodTable: UITableView = {
        let FoodTable = UITableView()
        FoodTable.register(FoodTableViewCell.self, forCellReuseIdentifier: "cell")
        FoodTable.translatesAutoresizingMaskIntoConstraints = false
        return FoodTable
    }()
    let TitleLabel: UILabel = {
        let TitleLable = UILabel()
        TitleLable.font = UIFont(name: "Hiragino Mincho ProN", size: 25)
        TitleLable.text = "Ingredients"
        TitleLable.textAlignment = .center
        TitleLable.textColor = .white
        return TitleLable
    }()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 450, width: UIScreen.main.bounds.width, height: 230), collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 720, width: UIScreen.main.bounds.width, height: 50))
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.purple
        pageControl.pageIndicatorTintColor = UIColor.gray
        return pageControl
    }()
//    var item = [RecipeDetail]()
    var ingredient = [ExtendedIngredients]()
    var analyzedInstruction = [AnalyzedInstructions]()
    var SelectRow: Int!
    var addString = ""
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(FoodTable)
        view.addSubview(TitleLabel)
        FoodTable.dataSource = self
        setupCollectionView()
        setupLayouts()
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        TitleLabel.frame = CGRect(x: 10, y: 80, width: 300, height: 60)
        FoodTable.frame = CGRect(x: 10, y: 150, width: 350, height:  300)
        FoodTable.rowHeight = 50

    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? FoodTableViewCell else { return UITableViewCell()}
        let ingredients = ingredient[indexPath.row]
        cell.ingredients = ingredients
        cell.update()
        cell.alertsDelegate = self
        return cell
    }
    private func setupLayouts(){
//        collectionView.constraints
    }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StepCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
        view.addSubview(pageControl)
        pageControl.numberOfPages = 5
    }
}
extension SearchDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return analyzedInstruction.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? StepCell else {return UICollectionViewCell()}
        let steps = analyzedInstruction[0].steps[indexPath.item]
//        cell.instructstep = steps
//        cell.update()
        cell.foodTextView.text = "\(steps.number)\n \(steps.step)"
        return cell
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        //collectionView cell之間的間隙
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        //collectionView每個cell的大小
        return CGSize(width: view.bounds.width, height: view.bounds.height)
    }
}
protocol alerts: class{
    func presentAlert(title:String, message:String)
}
class FoodTableViewCell: UITableViewCell {
    let cellLabel: UILabel = {
        let cellLabel = UILabel()
        cellLabel.font = UIFont(name: "Hiragino Mincho ProN", size: 20)
        return cellLabel
    }()
    let addButton: UIButton = {
        let addButton = UIButton(type: .contactAdd)
        addButton.tintColor = .purple
//        addButton.translatesAutoresizingMaskIntoConstraints = false
        return addButton
    }()
    var addString = ""
    var ingredients: ExtendedIngredients!
    var alertsDelegate: alerts?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        addButton.frame = CGRect(x: 0, y: 0, width: 25, height: 25)
        accessoryView = addButton
        addButton.addTarget(self, action: #selector(addtoList), for: .touchUpInside)
        cellLabel.numberOfLines = 0
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }
    override func awakeFromNib() {
        super.awakeFromNib()
        setupLayouts()
    }
    func setupLayouts() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.numberOfLines = 0
        cellLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: accessoryView!.leadingAnchor, constant: 20).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
    }
    func update(){
        let quantity = String(format:"%.2f", ingredients.amount) //substring the amount of food quatity
        if let unit = ingredients.unit {
            cellLabel.text = quantity + unit + ingredients.originalName
            addString = quantity + unit + ingredients.originalName
        }
    }
    private func setupLayout() {
        addSubview(cellLabel)
        cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 30).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true
        cellLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
    }
    @objc func addtoList() {
        currentFood.append(addString)  //將欲買食材加入至清單中 存入至userDefault
        UserDefaults.standard.setValue(currentFood, forKey: "food")
        food.append(addString)
        alertsDelegate?.presentAlert(title: "YOU HAVE ADDED IN YOUR LIST", message: "\(addString)")
        
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}