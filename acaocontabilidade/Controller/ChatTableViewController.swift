//
//  ChatTableViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 25/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit
import Firebase

class ChatTableViewController: UITableViewController {

    //Logged user preferences
    var loggedUserInfoArray: [User] = [User]()
    
    //Selected contact ("Conversa") preferences
    var contactId: String!
    var contact: User? {
        didSet {
            title = contact?.userName
        }
    }
    
    //Messages information
    var messageArray: [Message] = [Message]()
    var chatIdentifier: String? = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.separatorStyle = .none
        checkForExistingChat()
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        tableView.rowHeight = UITableViewAutomaticDimension
        
        if messageArray[indexPath.row].messageSenderId == self.loggedUserInfoArray[0].userId{
            //Logged user sent the message
             let sentMessagesCell = tableView.dequeueReusableCell(withIdentifier: "sentMessagesCell", for: indexPath) as! ChatSentMessageViewCell
            sentMessagesCell.nameLabel.text = messageArray[indexPath.row].messageBody
            return sentMessagesCell
            
        }

        //User contact sent the message
         let receivedMessagesCell = tableView.dequeueReusableCell(withIdentifier: "receivedMessagesCell", for: indexPath) as! ChatReceivedMessageViewCell
//        receivedMessagesCell.receivedMessageText.backgroundColor = UIColor.lightGray
//        receivedMessagesCell.receivedMessageText.textColor = UIColor.black
//        receivedMessagesCell.receivedMessageText.layer.cornerRadius = 5
//        receivedMessagesCell.receivedMessageText.layer.masksToBounds = true
        receivedMessagesCell.messageLabel.text = messageArray[indexPath.row].messageBody
        
        return receivedMessagesCell
    }
    
    

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    
    //MARK: Check if existing chat, if not create new
    private func checkForExistingChat(){
        Database.database().reference().child("user-chatContacts:chat").child(self.loggedUserInfoArray[0].userId).child(self.contactId).observeSingleEvent(of: DataEventType.value) { (snapshot) in
            let snapshotValue = snapshot.value as? String
            if snapshotValue != nil{
                self.chatIdentifier = snapshotValue
                self.retrieveMessages()
            }else{
                //TODO: Cria chat com contato
                //self.createNewChat
            }
        }
    }

    private func retrieveMessages(){
        Database.database().reference().child("chat-messages").child(self.chatIdentifier!).observe(DataEventType.childAdded) { (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String, AnyObject>
            if let text = snapshotValue["text"] as? String, let id = snapshotValue["senderId"] as? String, let email = snapshotValue["senderEmail"] as? String{
                
                let timeIntervalDouble = snapshotValue["timestamp"] as? Int64
                let timeInterval = TimeInterval.init(exactly: timeIntervalDouble! / 1000)
                let date = Date(timeIntervalSince1970: timeInterval!)
            
                //Store message properties in the object
                let message = Message()
                
                message.messageBody = text
                message.messageDate = date
                message.messageSenderId = id
                message.messageSenderEmail = email
                
                self.messageArray.append(message)
                self.tableView.reloadData()
                
                //TODO: Implementar a função de addMessage
            
            }else{
                //TODO: Implementar função de recebimento de imagens
                print("É uma imagem e precisa implementar")
            }
        }
    }
    
}
