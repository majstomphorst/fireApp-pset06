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

/*
 This class takes care of the main message view.
 It's a JSQMessageViewController (that inherits from UIViewController),
 so that i can use the bubblechat view that it supplies.
 
 It takes care of the following tasks:
 
 - It loads the UI.
 -- Displays the users userName in the navigation bar.
 -- Loads the bubble view, and hides the attachment button (this function is not used).
 
 - Prepares the JSQMessageViewController:
 -- Sends al necessary data to JSQMessageViewController.
 --- A UserPicture, Displayname, username, userid.
 
 - It places a observer or event lissener on a secondary thread.
 -- Loads the new text messages if received. 
 -- scrolls down the pages so that the text message is in view.
 
 
*/

class MessageViewController: JSQMessagesViewController {
    
    // store messages from firebase(database)
    var messages = [JSQMessage]()
    
    override func viewWillAppear(_ animated: Bool) {
        
        // hides the add attachment button from the UI
        self.inputToolbar.contentView.leftBarButtonItem = nil
        
        // this check if a user is login or not and get the userId
        if let userId = Auth.auth().currentUser?.uid {
           
            // reads the user's information by the user id
            Database.database().reference().child("users").child(userId)
                .observeSingleEvent(of: .value, with:
                    { (snapshot) in
                
                // converts the snapshot to a nsdictionary
                if let user = snapshot.value as? NSDictionary {
                    
                    // send the username to JSQMessages
                    self.senderDisplayName = user["username"] as? String
                    // send the userId to JSQMessages as senerId
                    self.senderId = userId
                    // Displays the username in the navigationbar (aesthetic)
                    self.navigationItem.title = self.senderDisplayName
                }
                
                // reads messages from Firbase and stores it in "messages"
                self.readMessages()
            })
            
        // if the user is not logedin send user to the loginscreen
        } else {
            performSegue(withIdentifier:"toSignIn", sender: nil)
        }
    }
    
    
    // MARK: - JSQMessage functions
    
    // displays a picture next to the message text
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!)
        -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory
                .avatarImage(with: UIImage(named:"chatBubble"), diameter: 30)
    }
    
    // creates a bubbel to display the message
    override func collectionView(_ collectionView: JSQMessagesCollectionView!,messageBubbleImageDataForItemAt indexPath: IndexPath!)
        -> JSQMessageBubbleImageDataSource! {
            
        // creats a instance from JSQMessages bubblefactory
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        
        return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
    }
    
    // returns the number of messages which need to be displayed
    override func collectionView(_ collectionView: UICollectionView,
                                 numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    // returns the value witch is stored inside the bubble
    override func collectionView(_ collectionView: UICollectionView,
                                 cellForItemAt indexPath: IndexPath)
                                                -> UICollectionViewCell {
            
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
            
        return cell
    }
    
    // returns the messages text which is displayd inside the cell
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item]
    }
    
    // when sendbuttons is pressed
    override func didPressSend(_ button: UIButton, withMessageText text: String,
                               senderId: String, senderDisplayName: String, date: Date) {
        
        // create reference to firebase where the message info is to be saved
        let reference = Database.database().reference().child("messages")
            .childByAutoId()
        
        // crating a dictionary with al the message information
        let message = ["text": text, "username": senderDisplayName,
                       "senderId": senderId]
        
        // saving the message at the reference location (in Firbase)
        reference.updateChildValues(message)
        
        // empty's the inputfield
        finishSendingMessage(animated: true)
        
        // scroll down to get the message in view
        scrollToBottom(animated: true)
    }
    
    
    // MARK: - Actions
    
    // if the logout button is pressed logout and return to the login page
    @IBAction func signOut(_ sender: Any) {
        do {
            try Auth.auth().signOut()
            
            
            // if the user is logout clear temporary storage
            messages = [JSQMessage]()
            
            // will stop all observers
            Database.database().reference().removeAllObservers()
            
            // sends user to login pages
            self.performSegue(withIdentifier: "toSignIn", sender: nil)
            
            // if error this send a alert to the user with the reason why
        } catch {
            alertUser(title: "logout went wrong", message: error.localizedDescription)
        }
    }
    
    // a link to MessageViewController to call a unwind action
    @IBAction func returnToMessage(segue: UIStoryboardSegue) {}
    
    
    // MARK: - Functions
    
    /*
     This functions read all messages from the Firdatabase, stores it in de "messages" variable of type "JSQMesage".
     It also places a observer or event lissener on the data so if the database changes this observer wil
     update. This is done on a second thread so that the user interface doesn't doesn't lag.
     When its done it reloads the messages view (to display the messages) on the main thread.
    */
    func readMessages() {
        
        // send the task to a second thread
        DispatchQueue.global(qos: .userInteractive).async {
            
            // getting al "messages" data
            Database.database().reference().child("messages").observe(.childAdded, with: { (snapshot) in
                
                // interpeting the made "snapshot" as a dictionary
                if let messages = snapshot.value as? NSDictionary {
                    
                    // properly formating and converting the Dictionary to JSQMessage type
                    self.messages.append(JSQMessage(senderId: messages["senderId"] as? String, displayName: messages["username"] as? String, text: messages["text"] as? String))
                    
                    
                    DispatchQueue.main.async {
                        
                        // reloading the messages view
                        self.collectionView.reloadData()
                        
                        // moving the screen down so that the last message is readble
                        self.scrollToBottom(animated: true)
                    }
                    
                } else {
                    self.alertUser(title: "Reading messages went wrong", message: "No feedback provided sorry!")
                }
            })
        }
    }
    

}
