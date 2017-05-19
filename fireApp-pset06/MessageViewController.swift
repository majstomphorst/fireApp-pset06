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
    
    var messages = [JSQMessage]()
    
    
    override func viewWillAppear(_ animated: Bool) {
        self.senderId = "1"
        self.senderDisplayName = "Tim"
        statusHandeler()
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, avatarImageDataForItemAt indexPath: IndexPath!) -> JSQMessageAvatarImageDataSource! {
        return JSQMessagesAvatarImageFactory.avatarImage(with: UIImage(named:"chatBubble"), diameter: 30)
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageBubbleImageDataForItemAt indexPath: IndexPath!) -> JSQMessageBubbleImageDataSource! {
        let bubbleFactory = JSQMessagesBubbleImageFactory()
        // let message = messages[indexPath.item]
        return bubbleFactory?.outgoingMessagesBubbleImage(with: UIColor.blue)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return messages.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = super.collectionView(collectionView, cellForItemAt: indexPath) as! JSQMessagesCollectionViewCell
        return cell
    }
    
    override func collectionView(_ collectionView: JSQMessagesCollectionView!, messageDataForItemAt indexPath: IndexPath!) -> JSQMessageData! {
        
        return messages[indexPath.item]
    }
    
    
    override func didPressSend(_ button: UIButton!, withMessageText text: String!, senderId: String!, senderDisplayName: String!, date: Date!) {
        
        messages.append(JSQMessage(senderId: senderId, displayName: senderDisplayName, text: text))
        // clears the text
        finishSendingMessage(animated: true)
        
        collectionView.reloadData()
    }
    
    
    // MARK: Actions
    @IBAction func returnToMessage(segue: UIStoryboardSegue) {}
    
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

}
