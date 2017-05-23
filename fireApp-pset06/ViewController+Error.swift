//
//  ViewController+Error.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 23/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    
    func alertUser(title: String, message: String) {
        
        // create the alert
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        // add an action (button)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        
        // show the alert
        self.present(alert, animated: true, completion: nil)
    
    }
    
}
