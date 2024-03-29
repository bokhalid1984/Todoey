//
//  ViewController.swift
//  Todoey
//
//  Created by shaheen on 10/13/19.
//  Copyright © 2019 shaheen. All rights reserved.
//

import UIKit

class TodoListViewController: UITableViewController {
    
    var itemArray =  [Item]()

    let dataFilePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent("Item.plist")
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        print(dataFilePath)
       
       
        
      loadItem()

        
//        if let items = defaults.array(forKey: "TodoListArray") as? [String] {
//            itemArray = items
//        }
    }
// MARK - TableView Datasource Methods

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return itemArray.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
  
      let cell = tableView.dequeueReusableCell(withIdentifier: "ToDoItemCell", for: indexPath)
        
        
        let item = itemArray[indexPath.row]
        
        cell.textLabel?.text = item.title
        
        //  Ternary operation==>
        // value = codition ? valueTrue  : valueFalse
        
        cell.accessoryType = item.done == true ? .checkmark : .none
        
        // we use above line of code   <<cell.accessoryType = item.done == true ? .checkmark : .none>>
               
        // insted of bellow codes
        
        
//        if item.done == true {
//            cell.accessoryType = .checkmark
//        }else {
//            cell.accessoryType = .none
//        }
        
        return cell
    }
    
    //MARK - TableView Delegate Methods
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(itemArray[indexPath.row])
        
        itemArray[indexPath.row].done = !itemArray[indexPath.row].done
        
        
        saveItem()
        
        // we use above line of code   <<    itemArray[indexPath.row].done = !itemArray[indexPath.row].done>
        // insted of bellow codes
        
//        if itemArray[indexPath.row].done == false {
//            itemArray[indexPath.row].done = true
//        }else{
//            itemArray[indexPath.row].done = false
//        }
     
       
    tableView.deselectRow(at: indexPath, animated: true)
    }
    //MARK - Add New Items
    @IBAction func addButtonPressed(_ sender: UIBarButtonItem) {
        var textField = UITextField()
        
        let alert = UIAlertController(title: "Add New Todoey Item", message: "", preferredStyle: .alert)
        let action = UIAlertAction(title: "Add Item", style: .default) { (action) in
            //What will happen once the user clicks the add Item Button on our UIAlert
            
            let newItem = Item()
            newItem.title = textField.text!
            
            self.itemArray.append(newItem)
            
            self.saveItem()
            
        }
        alert.addTextField { (alertTextField) in
            alertTextField.placeholder = "Create new item"
            textField = alertTextField
            
      
        }
        
        alert.addAction(action)
        
        present(alert, animated: true, completion: nil)
    }
    func saveItem (){
        let encoder = PropertyListEncoder()
                   do {
                       
                       let data = try encoder.encode(itemArray)
                       try data.write(to:dataFilePath!)
                   } catch {
                       print("Error encoding item array, \(error)")
                   }
                   self.tableView.reloadData()
                   
               }
    
    func loadItem(){
        if let data = try? Data(contentsOf: dataFilePath!) {
            let decoder = PropertyListDecoder()
            do {
            itemArray = try decoder.decode([Item].self, from: data)
            }
            catch{
            print("Error decoding item array,\(error)")
                
            }
        }
    }

    }



