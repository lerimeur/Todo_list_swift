//
//  Custom_cell.swift
//  Todo
//
//  Created by brasseur gregoire on 28/04/2020.
//  Copyright © 2020 PoC. All rights reserved.
//

import UIKit

class Custom_cell: UITableViewCell {

    @IBOutlet weak var title: UILabel!
    @IBOutlet weak var check_box: UIImageView!
    @IBOutlet weak var date: UILabel!
    @IBOutlet weak var prio: UILabel!
    
    var status: Bool = false
    
    override func awakeFromNib() {
        super.awakeFromNib()

    }
    
    @IBAction func check(_ sender: Any) {
        if(status == false) {
            check_box.image = UIImage(systemName: "checkmark.square.fill")
            status = true
        } else {
            check_box.image = UIImage(systemName: "checkmark.square")
            status = false
        }
    }
    
}
