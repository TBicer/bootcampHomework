//
//  ListRepository.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import Foundation
import RxSwift

class ListRepository {
    var taskList = BehaviorSubject<[Task]>(value: [Task]())
    let db:FMDatabase?
    
    init(){
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let veritabaniURL = URL(fileURLWithPath: hedefYol).appendingPathComponent("tasks.sqlite")
        
        db = FMDatabase(path: veritabaniURL.path)
    }
    
    func save(title:String, detail:String, order_number:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("INSERT INTO list (title,detail,order_number) VALUES (?,?,?)", values: [title,detail,order_number])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func update(id:Int,title:String, detail:String, order_number:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("UPDATE list SET title = ?, detail = ?, order_number = ? WHERE id = ?", values: [title,detail,order_number,id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func delete(id:Int){
        db?.open()
        
        do{
            try db!.executeUpdate("DELETE FROM list WHERE id = ?", values: [id])
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    func search(searchText:String){
        db?.open()
        
        do{
            var liste = [Task]()
            
            let rs = try db!.executeQuery("SELECT * from list WHERE title LIKE '%\(searchText)%' ", values: nil)
            
            while rs.next(){
                let id = Int(rs.string(forColumn: "id"))
                let title = rs.string(forColumn: "title")
                let detail = rs.string(forColumn: "detail")
                let order_number = Int(rs.string(forColumn: "order_number"))
                
                let task = Task(id: id!, title: title!, detail: detail!, order_number: order_number!)
                liste.append(task)
            }
            
            liste.sort(by: { $0.order_number! < $1.order_number!})
            
            taskList.onNext(liste)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
    
    
    func fetchData(){
        db?.open()
        
        do{
            var liste = [Task]()
            
            let rs = try db!.executeQuery("SELECT * from list", values: nil)
            
            while rs.next(){
                let id = Int(rs.string(forColumn: "id"))
                let title = rs.string(forColumn: "title")
                let detail = rs.string(forColumn: "detail")
                let order_number = Int(rs.string(forColumn: "order_number"))
                
                let task = Task(id: id!, title: title!, detail: detail!, order_number: order_number!)
                liste.append(task)
            }
            liste.sort(by: { $0.order_number! < $1.order_number!})
            
            taskList.onNext(liste)//Tetikleme
        }catch{
            print(error.localizedDescription)
        }
        
        db?.close()
    }
}
