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

    // Mark: Outlets
    @IBOutlet weak var nameLabel: UITextField!
    @IBOutlet weak var emailLabel: UITextField!
    @IBOutlet weak var passLabel: UITextField!
    @IBOutlet weak var pass2Label: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func registerButton(_ sender: Any) {
        let displayName = nameLabel.text
        let email = emailLabel.text
        let password = passLabel.text
        
        FIRAuth.auth()?.createUser(withEmail: email!, password: password!, completion: { ( user, error) in
            
            if error != nil {
                print(error!)
                return
            }
            // succus auth
            self.performSegue(withIdentifier: "backToMessage", sender: nil)
            
            guard let uid = user?.uid else {
                return
            }
            
            // save user
            let ref = FIRDatabase.database().reference(fromURL: "https://fireapp-pset06.firebaseio.com/")
            let userRef = ref.child("users").child(uid)
            
            let values = ["username": displayName!, "email" : email!]
            
            userRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                
                if err != nil {
                    print(err!)
                    return
                }
                // succes
            })
            
        })
        
        
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
