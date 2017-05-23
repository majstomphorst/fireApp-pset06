//
//  RegisterViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 18/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class RegisterViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passLabel: UITextField!
    
    //MARK: - Actions
    @IBAction func registerButton(_ sender: Any) {

        let displayName = nameLabel.text!
        let email = emailLabel.text!
        let password = passLabel.text!
        
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { ( user, error) in
            
            if error != nil {
                self.alertUser(title: "Creating user went wrong", message: error!.localizedDescription)
                return
            }
            // succus auth
            self.performSegue(withIdentifier: "backToMessage", sender: nil)
        
            guard let uid = user?.uid else {
                return
            }
            
            // save user
            let ref = FIRDatabase.database().reference().child("users").child(uid)
            
            let values = ["username" : displayName, "email" : email, "password" : password]
            
            ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                if error != nil {
                    print(error!)
                    return
                }
                
            })
            
        })
        
        
    }
    

}
