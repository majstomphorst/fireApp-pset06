//
//  Register.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 19/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//
// In this class you can find all the functions related to registrants
// - Login - Loginout - Register

import Foundation
import Firebase

class Register {
    
    static let shared = Register()
    
    var uid = ""
    
    private init() {
        
        
    }
    
    // this function checks is a user is logedin or not
    func checkLoginState() -> Bool {
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            return false
        }
        return true
    }
    
   
}


