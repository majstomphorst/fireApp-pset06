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
    
    override func viewWillAppear(_ animated: Bool) {
        
        handleError(title: "title", message: "message")
        
        // hides the "add attachment" button from te UI
        self.inputToolbar.contentView.leftBarButtonItem = nil
        
        // this check if a user is login or not
        // gets the userId for the currently logedin user
        if let userId = FIRAuth.auth()?.currentUser?.uid {
            
            // Reads the user's information by the userId
            FIRDatabase.database().reference().child("users").child(userId).observeSingleEvent(of: .value, with: { (snapshot) in
                
                // reads messages from Firbase and stores it in: var messages
                self.readMessages()
                
                if let user = snapshot.value as? NSDictionary {
                    self.senderDisplayName = user["username"] as? String
                    self.senderId = userId
                    self.navigationItem.title = self.senderDisplayName
                }
                
            })
            
        // if the user is not logedin send user to the loginscreen
        } else {
            performSegue(withIdentifier: "toLogin", sender: nil)
        }
        
    }
    
    
    // MARK: JSQMessage functions
    
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
        
        // creating a reference to firebase where the message info is to be saved
        let reference = FIRDatabase.database().reference().child("messages").childByAutoId()
        
        // crating a dictionary with al de message information
        let message = ["text" : text, "username" : senderDisplayName, "senderId" : senderId]
        
        // saving the message at the reference location
        reference.updateChildValues(message)
        
        // empty's the inputfield
        finishSendingMessage(animated: true)
        
        scrollToBottom(animated: true)
    }
    
    
    // MARK: - Actions
    
    // creates a segue back this is needed to make the slide down animations (unwinde)
    @IBAction func returnToMessage(segue: UIStoryboardSegue) {}
    
    // if the logout button is pressed logout and return to the login page
    @IBAction func logOut(_ sender: Any) {
        do {
            try FIRAuth.auth()?.signOut()
            
            // if the user is logout clear temporary storage
            messages = [JSQMessage]()
            
            self.performSegue(withIdentifier: "toLogin", sender: nil)
            
        } catch {
            handleError(title: "logout error", message: "please force shut down the app, and restart.")
        }
        
    }
    
    // MARK: - Functions
    
    /*
     This functions read all messages from the Firbaseands, stores it in de "messages" variable of type "JSQMesage".
     When its done it reloads the messages view (to display the messages).
    */
    func readMessages() {
        // getting al "messages" data!
        FIRDatabase.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
            
            // interpeting the made "snapshot" as a dictionary
            if let messages = snapshot.value as? NSDictionary {
                
                // properly formating and converting the Dictionary to JSQMessage type
                self.messages.append(JSQMessage(senderId: messages["senderId"] as? String, displayName: messages["username"] as? String, text: messages["text"] as? String))
                
            }
            
            // reloading the messages view
            self.collectionView.reloadData()
            
            // moving the screen down so that the last message is readble
            self.scrollToBottom(animated: true)
        })
    }
    


    
}
