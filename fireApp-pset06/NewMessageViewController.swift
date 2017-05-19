//
//  NewMessageViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 18/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class NewMessageViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    
    var users = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        // getting al "users" data!
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
            if var dict = snapshot.value as? [String : AnyObject]{
                self.users.append(dict["username"] as! String)
            }
            
           self.tableView.reloadData()
            
            })
        
        // Do any additional setup after loading the view.
    }
    

    // MARK: Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewMessageTableViewCell
        
        cell.usersLabel.text = users[indexPath.row]
        
        return cell
        
    }
    
    
   
}
