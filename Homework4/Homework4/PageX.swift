//
//  PageX.swift
//  Homework4
//
//  Created by Tunay Biçer on 21.09.2024.
//

import UIKit

class PageX: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func handleGoToY(_ sender: Any) {
        performSegue(withIdentifier: "moveXToY", sender: nil)
    }
    
}
