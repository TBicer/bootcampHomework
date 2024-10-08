//
//  NewTaskViewModel.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import Foundation

class NewTaskViewModel {
    var listRepo = ListRepository()
    
    func save(title: String, detail: String, order_number:Int, completion: @escaping () -> Void){
        listRepo.save(title: title, detail: detail, order_number: order_number)
        completion()
    }
}
