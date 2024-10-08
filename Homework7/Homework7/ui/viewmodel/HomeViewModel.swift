//
//  HomeViewModel.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import Foundation
import RxSwift

class HomeViewModel {
    var listRepo = ListRepository()
    var taskList = BehaviorSubject<[Task]>(value: [Task]())
    
    init(){
        veritabaniKopyala()
        fetchData()
        taskList = listRepo.taskList
    }
    
    func delete(id:Int){
        listRepo.delete(id: id)
        fetchData()
    }
    
    func search(searchText:String){
        listRepo.search(searchText: searchText)
    }
    
    func fetchData(){
        listRepo.fetchData()
    }
    
    func veritabaniKopyala(){
        let bundleYolu = Bundle.main.path(forResource: "tasks", ofType: ".sqlite")
        let hedefYol = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first!
        let kopyalanacakYer = URL(fileURLWithPath: hedefYol).appendingPathComponent("tasks.sqlite")
        let fileManager = FileManager.default
        if fileManager.fileExists(atPath: kopyalanacakYer.path){
            print("Veritabanı zaten var")
        }else{
            do{
                try fileManager.copyItem(atPath: bundleYolu!, toPath: kopyalanacakYer.path)
            }catch{}
        }
    }
    
}
