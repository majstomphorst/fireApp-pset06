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
    
    
    // this function checks is a user is logedin or not
    static func checkLoginState() throws -> Bool {
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            return false
        }
        return true
    }
    
    
    // this function returns the users displayname
    static func GetDisplayName() throws -> String {
        
        var user = [String: AnyObject]()
        
        let uid = FIRAuth.auth()?.currentUser?.uid
        FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
            
            
        })
        
        return (user["username"] as? String)!
        
    }
    
   
}


