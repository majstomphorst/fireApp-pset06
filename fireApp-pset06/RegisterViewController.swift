//
//  RegisterViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 18/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

/*
 This class takes care of the registration form.
 
 It imports the users credentials and try's to create an account on firebase.
 It alsow registries the user's info in a secondary nood of the database. (because of bugges)
 
 If the creating of the firebase account was succesvol and the user information is stored. 
 The user is send to the main messages view.
 */

class RegisterViewController: UIViewController {

    // Mark: - Outlets
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    
    //MARK: - Actions
    
    // if the user pressed register
    @IBAction func registerButton(_ sender: Any) {
        
        // collect information form form
        let displayName = nameField.text!
        let email = emailField.text!
        let password = passwordField.text!
        
        // this creates a user with the information in the register form
        Auth.auth().createUser(withEmail: email, password: password, completion: {
            (user, error) in
            
            // if error display alert with error information
            if error != nil {
                self.alertUser(title: "Creating user went wrong",
                               message: error!.localizedDescription)
                return
            }
            
            // getting the curent userId.
            guard let userId = user?.uid else {
                return
            }
            
            // creating a reference to where info is stored
            let reference = Database.database().reference().child("users")
                .child(userId)
            
            // create a dictionary with the information needed for registration
            let userInfo = ["username": displayName, "email": email, "password": password]
            
            // creats child with value userId and store userInfo under it
            reference.updateChildValues(userInfo, withCompletionBlock: {
                (error, reffrence) in
                
                if error != nil {
                    self.alertUser(title: "Saving user detials error",
                                   message: error!.localizedDescription)
                    return
                }
                
                // when the user creation succeded send user to message view
                self.performSegue(withIdentifier: "backToMessage", sender: nil)
            })
        })
    }
    

}
