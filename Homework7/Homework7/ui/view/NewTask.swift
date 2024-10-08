//
//  NewTask.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import UIKit

class NewTask: UIViewController {
    var viewModel = NewTaskViewModel()
    
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var orderTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerTouch))
        view.addGestureRecognizer(tapGesture)

    }
    @objc func triggerTouch() {
        view.endEditing(true)
    }
    
    @IBAction func saveButton(_ sender: Any) {
        if let title = titleTextField.text, let detail = detailTextField.text, let order_number = Int(orderTextField.text!) {
            viewModel.save(title: title, detail: detail, order_number: order_number) {
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    

}
