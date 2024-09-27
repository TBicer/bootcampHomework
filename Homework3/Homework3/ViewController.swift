//
//  ViewController.swift
//  Homework3
//
//  Created by Tunay Biçer on 27.09.2024.
//

import UIKit

class ViewController: UIViewController {

    var quantity:Int = 1
    
    @IBOutlet weak var ratingView: UIView!
    @IBOutlet weak var quantityView: UIView!
    
    @IBOutlet weak var quantityLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        ratingView.layer.cornerRadius = 15
        ratingView.layer.borderWidth = 1
        ratingView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
        
        quantityView.layer.cornerRadius = 15
        quantityView.layer.borderWidth = 1
        quantityView.layer.borderColor = UIColor(named: "BorderColor")?.cgColor
    }

    @IBAction func minusButton(_ sender: Any) {
        if quantity == 1 {
            return
        }
        quantity -= 1
        quantityLabel.text = String(quantity)
    }
    
    @IBAction func plusButton(_ sender: Any) {
        quantity += 1
        quantityLabel.text = String(quantity)
    }
}

