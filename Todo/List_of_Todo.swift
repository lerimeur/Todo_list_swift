//
//  List_of_Todo.swift
//  Todo
//
//  Created by brasseur gregoire on 28/04/2020.
//  Copyright © 2020 PoC. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class Todo_list: UIViewController {
    
    @IBOutlet weak var List: UITableView!
    
    struct todos {
        let titre: String
        let date: String
        let prio: Int
    }

    var Array:[todos] = []
    
    var result: [Any] = []
    override func viewWillAppear(_ animated: Bool) {
        get_todos()
    }

    override func viewDidLoad() {
        List.dataSource = self
        List.delegate = self
    }
    
    
    
    //MARK: -GET ALL TODO
    func get_todos() {
        let Appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = Appdelegate.persistentContainer.viewContext
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Todo")
        let sortDescriptor = NSSortDescriptor(key: "priority", ascending: true)
        let sortDescriptors = [sortDescriptor]
        request.sortDescriptors = sortDescriptors

        request.returnsObjectsAsFaults = false
        
        do {
            result = try context.fetch(request)
            
            if result.count > 0 {
                for r in result as! [NSManagedObject] {
                    let tmp_titre = r.value(forKey: "titre") as! String
                    let tmp_date = r.value(forKey: "date") as! String
                    let tmp_prio = r.value(forKey: "priority") as! Int
                    Array.append(todos(titre: tmp_titre, date: tmp_date, prio: tmp_prio))
                }
            }
        } catch {
            print("error while fetching")
        }
    }

    //MARK: -REMOVE ELEMENT IN TITRE AND CORE DATA
    func remove_element(str:String) {
        let Appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = Appdelegate.persistentContainer.viewContext
        
        for r in result as! [NSManagedObject] {
            if let username = r.value(forKey: "titre") as? String {
                if (username == str) {
                    context.delete(r)
                }
            }
        }
    }
}


    //MARK: - GESTION FOR LIST
extension Todo_list: UITableViewDataSource, UITableViewDelegate {

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "my_cell", for: indexPath) as? Custom_cell else {
            return UITableViewCell()
        }
        
        cell.title.text = Array[indexPath.row].titre
        cell.date.text = Array[indexPath.row].date

        if (Array[indexPath.row].prio == 2) {
            cell.prio.text = "!!!"
        }
        if (Array[indexPath.row].prio == 1) {
            cell.prio.text = "!!"
        }
        if (Array[indexPath.row].prio == 0) {
            cell.prio.text = "!"
        }
        return cell
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            remove_element(str: Array[indexPath.row].titre)
            Array.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .fade)

        }
    }
}
