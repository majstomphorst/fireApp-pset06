//
//  MessageViewController.swift
//  fireApp-pset06
//
//  Created by Maxim Stomphorst on 18/05/2017.
//  Copyright © 2017 Maxim Stomphorst. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController

class MessageViewController: JSQMessagesViewController {
    
    // a variable to store messages in the firebase
    var messages = [JSQMessage]()
    
    override func viewDidDisappear(_ animated: Bool) {
        messages = [JSQMessage]()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        if checkLoginState() {
            // update login header
            let userId = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(userId!).observeSingleEvent(of: .value, with: { (snapshot) in
                
                self.readFire()
                
                if let user = snapshot.value as? NSDictionary {
                    self.senderDisplayName = user["username"] as? String
                    self.senderId = userId
                    self.navigationItem.title = self.senderDisplayName
                } else {
                    // something error
                }
            })
            
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
        
    }
    
    // this function checks is a user is logedin or not
    func checkLoginState() -> Bool {
        
        if FIRAuth.auth()?.currentUser?.uid == nil {
            return false
        }
        return true
    }
    
    // MARK: JSQMessage actions
    
    // displays a picture next to the message text.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named:"chatBubble"), diameter: 30)
    }
    
    // creates a bubbel to display the message
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
    }
    
    // returns the number of messages which need to be displayed
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // returns the value witch is stored inside the bubble
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    // returns the messages text with is displayd inside the cell with is in the bubble
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        return messages[indexPath.item]
    }
    
    // when sendbuttons is pressed. ...............
    override func didPressSend(_ button: UIButton, withMessageText text: String, senderId: String, senderDisplayName: String, date: Date) {
        
        // ride data to firebase
        let ref = FIRDatabase.database().reference().child("messages").childByAutoId()
        let values = ["text" : text, "username" : senderDisplayName, "senderId" : senderId]
        ref.updateChildValues(values)
        
        finishSendingMessage(animated: true)
    }
    
    
    // MARK: Actions
    
    // creates a segue back this is needed to make the slide down animations (unwinde)
    @IBAction func returnToMessage(segue: UIStoryboardSegue) {}
    
    // if the logout button is pressed logout and return to the login page
    @IBAction func logOut(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
        } catch {
            print("logout faild")
        }
        
        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    // MARK: Functions
  
    func readFire() {
        // getting al "users" data!
        FIRDatabase.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
            
            if let messages = snapshot.value as? NSDictionary {
                self.messages.append(JSQMessage(senderId: messages["senderId"] as? String, displayName: messages["username"] as? String, text: messages["text"] as? String))
                
            }
            self.collectionView.reloadData()
        })
    }

}
