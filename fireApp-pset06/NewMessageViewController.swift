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
    
    let lst = ["test","test2"]

    var users = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // getting al "users" data!
        FIRDatabase.database().reference().child("users").observe(.childAdded, with: { (snapshot) in
            print(snapshot)
            
            if var dict = snapshot.value as? [String : AnyObject]{
                self.users.append(dict["username"] as! String)
            }
            print(self.users.count)
            print(self.users)
            
            })
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    // MARK: Table
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return lst.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as! NewMessageTableViewCell
        
        
        cell.usersLabel.text = lst[indexPath.row]
        
        
        return cell
    }
    
   


}
