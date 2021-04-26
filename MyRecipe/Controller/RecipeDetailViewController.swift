//
//  RecipeDetailViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/4/20.
//

import UIKit

class RecipeDetailViewController: UIViewController {

    @IBOutlet weak var FoodTable: UITableView!
    @IBOutlet weak var FoodServings: UITextField!
    @IBOutlet weak var QuantityStepper: UIStepper!
    let item: RecipeDetail
    var addString = ""
    var ingredient = [ExtendedIngredients]()
    var instruct = [AnalyzedInstructions]()
    var collecStep = [Step]()
//    lazy var stepinstructList: [String] = {
//        var stepinstruct = [Step]()
//
//            return stepinstruct
//        }()
    init?(coder: NSCoder, item: RecipeDetail) { //coder 以及欲傳的資料
        self.item = item
        super.init(coder: coder)
    }
    required init?(coder: NSCoder) {
        fatalError()
    }
    var servings: Double = 0.00
    var quantity: String = ""
    let collectionView: UICollectionView = {
        let flowLayout = UICollectionViewFlowLayout()
        flowLayout.minimumLineSpacing = 0
        flowLayout.minimumInteritemSpacing = 0
        flowLayout.scrollDirection = .horizontal
        flowLayout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 250)
        let collectionView = UICollectionView(frame: CGRect(x: 0, y: 500, width: UIScreen.main.bounds.width, height: 230), collectionViewLayout: flowLayout)
        collectionView.isPagingEnabled = true
        collectionView.showsHorizontalScrollIndicator = false
        return collectionView
    }()
        
    let pageControl: UIPageControl = {
        let pageControl = UIPageControl(frame: CGRect(x: 0, y: 720, width: UIScreen.main.bounds.width, height: 50))
        //pageControl.numberOfPages = 5//self.imageNameList.count
        //pageControl.numberOfPages = instruct[0].steps.count
        pageControl.currentPage = 0
        pageControl.tintColor = UIColor.purple
        pageControl.pageIndicatorTintColor = UIColor.gray;
        return pageControl;
    }()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = item.title
        view.addSubview(collectionView)
        QuantityStepper.value = Double(item.servings)
        FoodServings.text = "\(QuantityStepper.value)"
        ingredient = item.extendedIngredients
        instruct = item.analyzedInstructions
        collecStep = item.analyzedInstructions[0].steps
        //pageControl.numberOfPages = collecStep.count
        setupNavTitle()
        setupCollectionView()
        setupTableView()
    }
    func setupNavTitle() {
        self.title = item.title
        let frame = CGRect(x: 0, y: 0, width: 200, height: 40)
        let tlabel = UILabel(frame: frame)
        tlabel.text = self.title
//        tlabel.font = UIFont.boldSystemFont(ofSize: 17) //UIFont(name: "Helvetica", size: 17.0)
        tlabel.backgroundColor = UIColor.clear
        tlabel.adjustsFontSizeToFitWidth = true
        tlabel.textAlignment = .center
        self.navigationItem.titleView = tlabel
    }
    func setupTableView() {
        food = UserDefaults.standard.stringArray(forKey: "food") ?? []
        FoodTable.dataSource = self
        FoodTable.delegate = self
        
    }
    func setupCollectionView() {
        //let layout = UICollectionViewFlowLayout()
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.register(StepCell.self, forCellWithReuseIdentifier: "cellId")
        collectionView.reloadData()
        collectionView.scrollToItem(at: IndexPath(row: 0, section: 0), at: .left, animated: false)
        self.view.addSubview(pageControl)
    }
    @IBAction func ControlServings(_ sender: UIStepper) {
        //QuantityStepper.value = Double(item.servings)
        QuantityStepper.minimumValue = 0
        QuantityStepper.maximumValue = 100
        QuantityStepper.stepValue = 1
        QuantityStepper.autorepeat = true
        FoodServings.text = "\(QuantityStepper.value)"
        FoodTable.reloadData()
    }
    @IBAction func ControlQuantity(_ sender: UITextField) {
        sender.value(forKey: "\(QuantityStepper.value)")
        FoodServings.text = "\(sender)"
        FoodTable.reloadData()
    }
    
    @IBAction func AddFood(_ sender: UIButton) {
        let buttonPointOnCell = sender.convert(CGPoint.zero, to: FoodTable)
        table.reloadData()
        if let indexfood = FoodTable.indexPathForRow(at: buttonPointOnCell) {
            quantity = String(format:"%.2f", Double(ingredient[indexfood.row].amount / Double(item.servings)) * QuantityStepper.value)
            if let unit = ingredient[indexfood.row].unit {
                addString = quantity + unit + "\(ingredient[indexfood.row].originalName)"
            }
        }
        currentFood.append(addString)
        UserDefaults.standard.setValue(currentFood, forKey: "food")
        food.append(addString)
        let alertController = UIAlertController(title: "YOU HAVE ADDED IN YOUR LIST", message: "", preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default))
        present(alertController, animated: true) {
            table.reloadData()
        }
    }
    
}
extension RecipeDetailViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        ingredient.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = FoodTable.dequeueReusableCell(withIdentifier: "food") as! IngredientTableViewCell
        //cell.foodLabel.font = UIFont(name: "Hiragino Mincho ProN", size: 12)
        let items = ingredient[indexPath.row]
        quantity = String(format:"%.2f", Double(items.amount / Double(item.servings)) * QuantityStepper.value)
        if let unit = items.unit {
            cell.foodLabel.text =  quantity + unit + " \(items.originalName)"
        }
        return cell
    }
}
extension RecipeDetailViewController: UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // 防止崩潰
//        if (collecStep.count == 0) {
//            return 0
//        }
//        return collecStep.count + 2
        collecStep.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cellId", for: indexPath) as! StepCell
        //cell.backgroundColor = indexPath.item % 2 == 0 ? .red : .yellow
        cell.foodTextView.text = "\(instruct[0].steps[indexPath.item].number)\n \(instruct[0].steps[indexPath.item].step)"
        /// 給text賦值（在首尾分別添加兩text）
//        if (indexPath.item == 0) {
//            cell.IngreText = "\(collecStep.last)"
//           // cell.imageName = imageNameList.last
//        } else if (indexPath.row == collecStep.count + 1) {
//            cell.IngreText = "\(collecStep.first)"
//            // cell.imageName = imageNameList.first
//        } else {
//            cell.IngreText = "\(collecStep[indexPath.item - 1])"
//        }
        return cell
    }

}
extension RecipeDetailViewController: UICollectionViewDelegate {
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        /// 當UIScrollView滑動到第一位停止時，將UIScrollView的偏移位置改變
//        if (scrollView.contentOffset.x == 0) {
//            scrollView.contentOffset = CGPoint(x: CGFloat(collecStep.count) * UIScreen.main.bounds.width,y: 0)
//            self.pageControl.currentPage = collecStep.count
//            /// 當UIScrollView滑動到最後一位停止時，將UIScrollView的偏移位置改變
//        } else if (scrollView.contentOffset.x == CGFloat(collecStep.count + 1) * UIScreen.main.bounds.width) {
//            scrollView.contentOffset = CGPoint(x: UIScreen.main.bounds.width,y: 0)
//            pageControl.currentPage = 0
//        } else {
//            pageControl.currentPage = Int(scrollView.contentOffset.x / UIScreen.main.bounds.width) - 1
//        }
    }
}
extension RecipeDetailViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: collectionView.frame.width, height: collectionView.frame.height)
    }
}
