//
//  ViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 17/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        FIRAuth.auth()?.createUser(withEmail: "maxim@s.eu", password: "maxim1", completion: { ( user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            // succus auth

            guard let uid = user?.uid else {
                return
            }
           
        
            
            // save user
            let ref = FIRDatabase.database().reference(fromURL: "https://fireapp-pset06.firebaseio.com/")
            let userRef = ref.child("users").child(uid)
            
            let values = ["key": "value"]
  
            userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                // succes
            })
            
        })
        
        
        
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

