//
//  MessageViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 18/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase

class MessageViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        statusHandeler()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func statusHandeler() {
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            self.performSegue(withIdentifier: "toLogin", sender: nil)

//            let toLoginVC = self.storyboard?.instantiateViewController(withIdentifier: "LoginVC") as! LoginViewController
//            
//            self.navigationController?.pushViewController(toLoginVC, animated: true)
//            
//            
        
            
    }
        
        
        
        if FIRAuth.auth()?.currentUser?.uid != nil {
            print("yes login")
        } else {
            print("no login")
        }
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
