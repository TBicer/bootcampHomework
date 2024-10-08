//
//  TaskDetail.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import UIKit

protocol UpdateTableData {
    func updateData()
}

class TaskDetail: UIViewController {
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var detailTextField: UITextField!
    @IBOutlet weak var orderTextField: UITextField!
    
    var task:Task?
    var viewModel = TaskDetailViewModel()
    
    var delegate : UpdateTableData?

    override func viewDidLoad() {
        super.viewDidLoad()

        if let t = task {
            titleTextField.text = t.title
            detailTextField.text = t.detail
            orderTextField.text = String(t.order_number!)
        }
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(triggerTouch))
        view.addGestureRecognizer(tapGesture)
    }

    @IBAction func updateButton(_ sender: Any) {
        if let t = task, let title = titleTextField.text, let detail = detailTextField.text, let order_number = Int(orderTextField.text!) {
            viewModel.update(id: t.id!, title: title, detail: detail, order_number: order_number) {
                self.delegate!.updateData()
                self.dismiss(animated: true)
            }
        }
    }
    
    @objc func triggerTouch() {
        view.endEditing(true)
    }
}
