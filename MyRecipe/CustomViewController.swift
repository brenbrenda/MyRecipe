//
//  CustomViewController.swift
//  MyRecipe
//
//  Created by chia on 2021/3/21.
//

import UIKit

class CustomViewController: UIViewController {

    @IBOutlet weak var RedSlider: UISlider!
    @IBOutlet weak var RedValue: UILabel!
    @IBOutlet weak var GreenSlider: UISlider!
    @IBOutlet weak var GreenValue: UILabel!
    @IBOutlet weak var BlueSlider: UISlider!
    @IBOutlet weak var BlueValue: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    @IBAction func ChangeColor(_ sender: UISlider) {
        RedValue.text = String(RedSlider.value)
        GreenValue.text = String(GreenSlider.value)
        BlueValue.text = String(BlueSlider.value)
        //BlueValue.text =
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
