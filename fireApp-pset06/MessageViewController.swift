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
        self.senderId = "1"
        self.senderDisplayName = "Tim"
        
        readFire()
        
        if Register.shared.checkLoginState() {
            // update login header
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let user = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = user["username"] as? String
                }
                
            })
            
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
        
        
    }
    
    
    // MARK: JSQMessage actions
    
    // displays a picture next to the message text.
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named:"chatBubble"), diameter: 30)
    }
    
    // creates a bubbel to display the message
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        // let message = messages[indexPath.item]
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
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        
        // ride data to firebase
        let ref = FIRDatabase.database().reference().child("messages").childByAutoId()
        let values = ["text": text!, "username": self.navigationItem.title!]
        ref.updateChildValues(values)
        
        
        finishSendingMessage(animated: true)
        
        collectionView.reloadData()
    }
    
    
    // MARK: Actions
    
    // creates a segue back this is needed to make the slide down animations (unwinde)
    @IBAction func returnToMessage(segue: UIStoryboardSegue) {}
    
    // if the logout button is pressed logout and return to the login page
    @IBAction func logOut(_ sender: Any) {
        Help.logout()
        self.performSegue(withIdentifier: "toLogin", sender: nil)
    }
    
    // MARK: Functions
    func statusHandeler() {
        
        // checks if the user is loged in if not send them to the login / register page
        if FIRAuth.auth()?.currentUser?.uid == nil {
            self.performSegue(withIdentifier: "toLogin", sender: nil)
        } else {
            let uid = FIRAuth.auth()?.currentUser?.uid
            FIRDatabase.database().reference().child("users").child(uid!).observe(.value, with: { (snapshot) in
                
                if let user = snapshot.value as? [String: AnyObject] {
                    self.navigationItem.title = user["username"] as? String
                }
                
            })
        }
        // for debuding
        Help.status()
    }
    
    func readFire() {
        // getting al "users" data!
        FIRDatabase.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
            
            if var dict = snapshot.value as? [String : AnyObject]{
                self.messages.append(JSQMessage(senderId: self.senderId, displayName: self.senderDisplayName, text: dict["text"] as! String))
                
            }
            self.collectionView.reloadData()
        })
    }

}
