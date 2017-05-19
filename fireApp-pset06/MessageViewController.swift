//
//  MessageViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 18/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController {
    
    
    override func viewWillAppear(_ animated: Bool) {
        statusHandeler()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        statusHandeler()
    }

    @IBAction func returnToMessage(segue: UIStoryboardSegue) {}
    
    func statusHandeler() {
        
        // checks if the user is loged in if not send them to the login / register page
        if FIRAuth.auth()?.currentUser?.uid == nil {
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let user = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = user["username"] as? String
                }
                
            })
        }
        // for debuding
        Help.status()
    }
    
    @IBAction func logOut(_ sender: Any) {
        Help.logout()
        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    

}
