//
//  SignInViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 17/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class SignInViewController: UIViewController {

    //MARK: - outlets
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passwordLabel: UITextField!

    //MARK: - actions
    
    // If the user pressed the loginbutton
    @IBAction func loginButton(_ sender: Any) {
        
        // getting data from user
        let email: String = emailLabel.text!
        let password: String = passwordLabel.text!
        
        // signin the user in to there account with the information provided
        Auth.auth().signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                
                // if a error happend this wil tell the user about it
                self.alertUser(title: "Sining in went wrong", message: error!.localizedDescription)
                
            } else {
                // when de user is signin the user is send to the messages view
                self.performSegue(withIdentifier: "backToMessage", sender: nil)
            }
        }

    }
    
    // privodes a link to RegisterViewController so that a unwind action can be called
    @IBAction func returnToLogin(segue: UIStoryboardSegue) {}
    

}

