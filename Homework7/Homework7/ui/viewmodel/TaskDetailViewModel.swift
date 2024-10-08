//
//  TaskDetailViewModel.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import Foundation

class TaskDetailViewModel {
    var listRepo = ListRepository()
    
    func update(id: Int, title: String, detail: String, order_number:Int, completion: @escaping () -> Void){
        listRepo.update(id: id, title: title, detail: detail, order_number: order_number)
        completion()
    }
    
    func fetchData(){
        listRepo.fetchData()
        print("view model fetch")

    }
}
