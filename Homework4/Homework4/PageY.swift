//
//  PageY.swift
//  Homework4
//
//  Created by Tunay Biçer on 21.09.2024.
//

import UIKit

class PageY: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    // back tuşuna basıldığında anasayfaya döndürüyor.
    override func viewWillDisappear(_ animated: Bool) {
        navigationController?.popToRootViewController(animated: true)
    }
    
    // ortadaki tuşa basıldığında döndürüyor
    @IBAction func handleGoToHomepage(_ sender: Any) {
        navigationController?.popToRootViewController(animated: true)
    }
    

}
