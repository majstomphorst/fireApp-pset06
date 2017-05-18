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
        
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("logout faild")
        }
        
        // if user is not loged in
        if FIRAuth.auth()?.currentUser?.uid == nil {
            print("no user logedin")
        }
        
        if FIRAuth.auth()?.currentUser?.uid != nil {
            print("user logedin!!!!!!!")
        }
        
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
        print(email)
        print(password)
        
        FIRAuth.auth()?.signIn(withEmail: email, password: password) { (user, error) in
            if error != nil {
                print(error)
            }
            
            guard let uid = user?.uid else {
                return
            }
            print(uid)
            

            if FIRAuth.auth()?.currentUser?.uid != nil {
                print("user logedin!!!!!!!")
            } else {
                print("no user logedin")
            }
        }
        
        emailLabel.text = ""
        passwordLabel.text = ""
        
        
        
        
    }


}

