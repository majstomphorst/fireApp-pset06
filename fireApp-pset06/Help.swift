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
    
    static func statusHandeler() {
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            
        }
        
        
        
        if FIRAuth.auth()?.currentUser?.uid != nil {
            print("yes login")
        } else {
            print("no login")
        }
    }
    
    static func logout() {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("logout faild")
        }
        
    }
}
