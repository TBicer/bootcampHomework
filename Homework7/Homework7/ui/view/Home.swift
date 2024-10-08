//
//  ViewController.swift
//  Homework7
//
//  Created by Tunay Biçer on 8.10.2024.
//

import UIKit

class Home: UIViewController, UpdateTableData {
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var listTableView: UITableView!
    
    var viewModel = HomeViewModel()
    var taskList = [Task]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchBar.delegate = self
        listTableView.delegate = self
        listTableView.dataSource = self
        
        _ = viewModel.taskList.subscribe(onNext: {liste in
            self.taskList = liste
            self.listTableView.reloadData()
        })
        
    }
    
    func updateData() {
        viewModel.fetchData()
        listTableView.reloadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        viewModel.fetchData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetail" {
            if let task = sender as? Task {
                let targetVC = segue.destination as! TaskDetail
                targetVC.task = task
                targetVC.delegate = self
                
            }
        }
    }
}

extension Home : UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.search(searchText: searchText)
    }
}

extension Home : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return taskList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell") as! ListCell
        let task = taskList[indexPath.row]
        
        cell.titleLabel.text = task.title
        cell.detailLabel.text = task.detail
            
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = taskList[indexPath.row]
        performSegue(withIdentifier: "toDetail", sender: task)
        listTableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let deleteAction = UIContextualAction(style: .destructive, title: "Sil"){ contextualAction, view, bool in
            let task = self.taskList[indexPath.row]
            
            let alert = UIAlertController(title: "Silme İşlemi", message: "\(task.title!) silinsin mi?", preferredStyle: .alert)
            let cancelAction = UIAlertAction(title: "Iptal", style: .cancel)
            alert.addAction(cancelAction)
            let yesAction = UIAlertAction(title: "Evet", style: .destructive){ action in
                self.viewModel.delete(id: task.id!)
            }
            alert.addAction(yesAction)
            
            self.present(alert, animated: true)
        }
        
        return UISwipeActionsConfiguration(actions: [deleteAction])
    }
    
    
}
