//
//  LoginViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 17/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    //MARK: outlets
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!
    
    // privodes a link to RegisterVC so that a unwind action can be called
    @IBAction func returnToLogin(segue: UIStoryboardSegue) {}
    
    //Mark: actions
    @IBAction func loginButton(_ sender: Any) {
        
        // getting data from user
        let email: String = emailLabel.text!
        let password: String = passwordLabel.text!
        
        
        // Sining the user in to there account with the information provided
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                
                self.alertUser(title: "Sining in went wrong", message: error!.localizedDescription)
                
            } else {
                self.performSegue(withIdentifier: "backToMessage", sender: nil)
            }
            
        }
    
        
    }


}

