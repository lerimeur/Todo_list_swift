//
//  File.swift
//  Todo
//
//  Created by brasseur gregoire on 27/04/2020.
//  Copyright © 2020 PoC. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class NewTodo: UIViewController {
    
    @IBOutlet weak var text: UITextField!
    @IBOutlet weak var priority: UISegmentedControl!

    override func viewDidLoad() {
         NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 50 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    
    @IBAction func Cancel(_ sender: Any) {
        performSegue(withIdentifier: "return_to_list", sender: self)
    }
    
    @IBAction func Done(_ sender: Any) {
        let prio = priority.selectedSegmentIndex
        let Appdelegate = UIApplication.shared.delegate as! AppDelegate
        let context = Appdelegate.persistentContainer.viewContext
        let new_todo = NSEntityDescription.insertNewObject(forEntityName: "Todo", into: context)
        
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd"
        let now = df.string(from: Date())

        new_todo.setValue(text.text, forKey: "titre")
        new_todo.setValue(prio, forKey: "priority")
        new_todo.setValue(now, forKey: "date")
        
        do {
            try context.save()
            print("succes context was saved")
        } catch {
            print("error context canot save")
        }
        performSegue(withIdentifier: "return_to_list", sender: self)
    }
    
}
