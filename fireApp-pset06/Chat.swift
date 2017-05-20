//
//  Chat.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 19/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import Foundation
import Firebase
import JSQMessagesViewController

class Chat {
    
    static let shared = Chat()
    
    var messages = [JSQMessage]()
    
    private init(){ 
        
    }
    
}
