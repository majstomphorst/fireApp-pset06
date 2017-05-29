//
//  ViewController+Error.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 23/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

/*
 This extension create's a convincent way to create alert notifiaction too alert the user
 if any error occurs. 
*/


import Foundation
import UIKit

extension UIViewController {
    
    /*
     This creates a alert message for the user to give them feedback to tel them,
     what is happening in the background especially our messages
    */
    func alertUser(title: String, message: String) {
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    
    }
    
}
