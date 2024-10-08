//
//  Task.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import Foundation

class Task {
    var id:Int?
    var title:String?
    var detail:String?
    var order_number:Int?
    
    init(id: Int, title: String, detail: String, order_number:Int) {
        self.id = id
        self.title = title
        self.detail = detail
        self.order_number = order_number
    }
}
