//
//  ViewController.swift
//  Lab6 TableView
//
//  Created by Pavan savaliya on 2024-02-18.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var tasks = [String]()
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let savedTasks = UserDefaults.standard.array(forKey: "tasks") as? [String] {
                    tasks = savedTasks
                }
        tableView.delegate = self
        tableView.dataSource = self
    }
    @IBAction func AddItemBtn(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        let alert = UIAlertController(title: "Add Item", message: "", preferredStyle: .alert)
        let cancel = UIAlertAction(title: "Cancel", style: .default){
            (cancel) in
        }
        let OK = UIAlertAction(title: "OK", style: .default){ (OK) in
            self.tasks.append(textField.text!)
            self.tableView.reloadData()
            UserDefaults.standard.set(self.tasks, forKey: "tasks")
        }
        
        alert.addTextField{ (text) in
            textField = text
            textField.placeholder = "Write an Item"
        }
        alert.addAction(cancel)
        alert.addAction(OK)
        self.present(alert, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tasks.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "TodolistTblView", for: indexPath)
        cell.textLabel?.text = tasks[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
            if editingStyle == .delete {
                tasks.remove(at: indexPath.row)
                self.tableView.reloadData()
                UserDefaults.standard.set(tasks, forKey: "tasks")
            }
        }
    
    @IBOutlet var tableView: UITableView!
    


}

