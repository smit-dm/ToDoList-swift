//
//  ViewController.swift
//  Lab7ToDoList
//
//  Created by Smit Mehta on 2022-08-05.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tableCell = tableView.dequeueReusableCell(withIdentifier: "cells", for: indexPath)
        tableCell.textLabel?.text = listItems[indexPath.row]
        return tableCell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if(editingStyle == UITableViewCell.EditingStyle.delete)
        {
            //Passing the row value
            listItems.remove(at:indexPath.row)
            //removing from table
            table.deleteRows(at: [indexPath], with: .automatic)
            
        }
    }
    

     
    private let table: UITableView = {
        let table = UITableView()
        table.register(UITableViewCell.self, forCellReuseIdentifier: "cells")
        return table
    }()
    
    var listItems = [String]()
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        self.listItems = UserDefaults.standard.stringArray(forKey: "cells") ?? []
        title = "To Do List"
        view.addSubview(table)
        table.dataSource = self
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(didTapAdd))
    }
    
    @objc private func didTapAdd(){
        let alert = UIAlertController(title: "Add New Item", message: "Enter NEW ITEM to List", preferredStyle: .alert)
        alert.addTextField{ field in field.placeholder = "Enter here..."
        }
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        alert.addAction(UIAlertAction(title: "ADD", style: .default, handler: {[weak self] (_) in
            if let txtField = alert.textFields?.first {
                if let text = txtField.text, !text.isEmpty {
                    
                    // ADDING ITEM
                    DispatchQueue.main.async{
                        var currentItems = UserDefaults.standard.stringArray(forKey: "items") ?? []
                        currentItems.append(text)
                        UserDefaults.standard.setValue(currentItems, forKey: "items")
                        self?.listItems.append(text)
                        self?.table.reloadData()

                    }
                }
            }
        }))
        present(alert, animated: true)
    }
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        table.frame = view.bounds
    }
    
    
}

