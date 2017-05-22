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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // this function privodes a link to RegisterVC to go back with a slide out animation
    @IBAction func returnToLogin(segue: UIStoryboardSegue) {}
    
    //Mark: actions
    @IBAction func loginButton(_ sender: Any) {
        let email: String = emailLabel.text!
        let password: String = passwordLabel.text!
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error!)
            } else {
                self.performSegue(withIdentifier: "backToMessage", sender: nil)
            }
            
            Help.status()
        }
    
        
    }


}

