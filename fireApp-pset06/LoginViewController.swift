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
    @IBOutlet weak var userNameText: UITextField!
    @IBOutlet weak var passwordText: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func returnToLogin(segue: UIStoryboardSegue) {}
    
    //Mark: actions
    @IBAction func loginButton(_ sender: Any) {
        let email = userNameText.text
        let password = passwordText.text
        
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { ( user, error) in
            
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
            
            let values = ["email" : email!, "password": password!]
            
            userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                // succes
            })
            
        })
        
    }


}

