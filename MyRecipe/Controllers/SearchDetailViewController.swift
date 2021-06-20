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
        let FoodTable = UITableView(frame: CGRect(x: 10, y: 150, width: 350, height:  300))//FoodTable.frame = CGRect(x: 10, y: 150, width: 350, height:  300)
        FoodTable.rowHeight = 50
        FoodTable.register(FoodTableViewCell.self, forCellReuseIdentifier: "cell")
        FoodTable.translatesAutoresizingMaskIntoConstraints = false
        return FoodTable
    }()
    let TitleLabel: UILabel = {
        let TitleLabel = UILabel(frame: CGRect(x: 10, y: 80, width: 300, height: 50))// TitleLabel.frame = CGRect(x: 10, y: 80, width: 300, height: 60)
        TitleLabel.font = UIFont(name: "Hiragino Mincho ProN", size: 25)
        TitleLabel.text = "Ingredients"
        TitleLabel.textAlignment = .center
        TitleLabel.textColor = .white
        TitleLabel.translatesAutoresizingMaskIntoConstraints = false
        return TitleLabel
    }()
    let StepLabel: UILabel = {
        let StepLabel = UILabel()
        StepLabel.font = UIFont(name: "Hiragino Mincho ProN", size: 25)
        StepLabel.text = "Follow the Instructions below:"
        StepLabel.textAlignment = .center
        StepLabel.textColor = .white
        StepLabel.translatesAutoresizingMaskIntoConstraints = false
        return StepLabel
    }()
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.scrollDirection = .horizontal
        //flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 450, width: UIScreen.main.bounds.width, height: 230), collectionViewLayout: flowLayout)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
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
        FoodTable.dataSource = self
        setupCollectionView()
       
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupLayouts()
    }
    
    private func setupLayouts(){
        view.addSubview(TitleLabel)
        TitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        TitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        TitleLabel.topAnchor.constraint(equalTo: view.topAnchor, constant: 100).isActive = true
        TitleLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
//        TitleLabel.bottomAnchor.constraint(equalTo: view.topAnchor, constant: 50).isActive = true
        view.addSubview(FoodTable)
        FoodTable.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30).isActive = true
        FoodTable.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30).isActive = true
        FoodTable.topAnchor.constraint(equalTo: TitleLabel.bottomAnchor, constant: 10).isActive = true
        FoodTable.heightAnchor.constraint(equalToConstant: 300).isActive = true
        view.addSubview(StepLabel)
        StepLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        StepLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        StepLabel.topAnchor.constraint(equalTo: FoodTable.bottomAnchor, constant: 10).isActive = true
        StepLabel.heightAnchor.constraint(equalToConstant: 35).isActive = true
        collectionView.leadingAnchor.constraint(equalTo: view.leadingAnchor).isActive = true
        collectionView.trailingAnchor.constraint(equalTo: view.trailingAnchor).isActive = true
        collectionView.topAnchor.constraint(equalTo: StepLabel.bottomAnchor, constant: 10).isActive = true
        collectionView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -20).isActive = true
        collectionView.backgroundColor = .clear
        
    }
    private func setupCollectionView() {
        view.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.register(StepCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
//        view.addSubview(pageControl)
//        pageControl.numberOfPages = 5
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
}
extension SearchDetailViewController: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return analyzedInstruction[0].steps.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as? StepCell else {return UICollectionViewCell()}
//        cell.backgroundColor = indexPath.item % 2 == 0 ? .purple : .yellow
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
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
protocol alerts: class{
    func presentAlert(title:String, message:String)
}
class FoodTableViewCell: UITableViewCell {
    let cellLabel: UILabel = {
        let cellLabel = UILabel(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width-50, height: 50))
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
//        cellLabel.numberOfLines = 0
        setupLayouts()
       
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    private func setupLayouts() {
        cellLabel.translatesAutoresizingMaskIntoConstraints = false
        cellLabel.numberOfLines = 0
        addSubview(cellLabel)
        cellLabel.topAnchor.constraint(equalTo: topAnchor, constant: 2).isActive = true
        cellLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10).isActive = true
        cellLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -35).isActive = true
        cellLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: 2).isActive = true
    }
    func update(){
        let quantity = String(format:"%.2f", ingredients.amount) //substring the amount of food quatity
        if let unit = ingredients.unit {
            cellLabel.text = quantity + unit + ingredients.originalName
            addString = quantity + unit + ingredients.originalName
        }
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
