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
    
    // if the user pressed register
    @IBAction func registerButton(_ sender: Any) {
        
        // collect information form form
        let displayName = nameLabel.text!
        let email = emailLabel.text!
        let password = passLabel.text!
        
        // this creates a user with the information in the register form
        FIRAuth.auth()?.createUser(withEmail: email, password: password, completion: { ( user, error) in
            
            // if there is an error while creating the user this wil display a message and tel the user the reason
            if error != nil {
                self.alertUser(title: "Creating user went wrong", message: error!.localizedDescription)
                return
            }
            
            // getting the curent userId.
            guard let userId = user?.uid else {
                return
            }
            
            // save user
            let ref = FIRDatabase.database().reference().child("users").child(userId)
            
            let values = ["username" : displayName, "email" : email, "password" : password]
            
            ref.updateChildValues(values, withCompletionBlock: { (error, ref) in
                
                if error != nil {
                    self.alertUser(title: "Saving user detials went wrong", message: error!.localizedDescription)
                    return
                }
                // when the user creation succeded send user to message view
                self.performSegue(withIdentifier: "backToMessage", sender: nil)
                
            })
            
        })
        
        
    }
    

}
