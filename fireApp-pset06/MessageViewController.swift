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

    override func viewDidLoad() {
        super.viewDidLoad()
        statusHandeler()
//        self.navigationItem.title = "Name?"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
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
        
        
        // for bebugging
        if FIRAuth.auth()?.currentUser?.uid != nil {
            print("yes login")
        } else {
            print("no login")
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
