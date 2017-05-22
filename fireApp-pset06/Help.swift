//
//  Help.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 18/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import Foundation
import Firebase

class Help {
    
    static func status() {
        // for bebugging
        if FIRAuth.auth()?.currentUser?.uid != nil {
            print("yes login")
        } else {
            print("no login")
        }
    }
    
    
}
