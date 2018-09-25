//
//  ConversasTableViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 24/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit
import Firebase
import SVProgressHUD

class ConversasTableViewController: UITableViewController{
 
    var loggedUserInfoArray: [User] = [User]()
    var contactsArray: [User] = [User]()
    
    //MARK: Date & Time variables
    var date = Date()
    let calendar = Calendar.current
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        SVProgressHUD.show()
        
        //1: Gather user information
        getLoggedUserPreferences()
        
        //2: Gather user contacts
        loadUserContacts()
        
    }

    
    //MARK: Table view datasource
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return contactsArray.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "conversasCell", for: indexPath) as! ConversasTableViewCell
        cell.configureCell(name: contactsArray[indexPath.row].userName)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let navigationBarHeight = self.navigationController!.navigationBar.frame.height
        let tabBarHeight = (self.tabBarController?.tabBar.frame.height)!
        let height = (UIScreen.main.bounds.height - navigationBarHeight - tabBarHeight - 20) / CGFloat(contactsArray.count)
        return height
    }


    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selection = contactsArray[(indexPath as NSIndexPath).row]
        self.performSegue(withIdentifier: "goToChat", sender: selection)
        
    }
    
    // MARK: Go to chat with selected contact
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        
        if let selectedContact = sender as? User {
            let chatVC = segue.destination as! ChatTableViewController
            
            //Selected contact objects
            chatVC.contact = selectedContact
            chatVC.contactId = selectedContact.userId
            
            //Logged user objects flow
            chatVC.loggedUserInfoArray = self.loggedUserInfoArray
        }

    }
    
    //MARK: Logged user info
    func getLoggedUserPreferences(){
        let currentUser = Auth.auth().currentUser
         Database.database().reference().child("users").child((currentUser?.uid)!).observeSingleEvent(of: .value) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, String>
            let user = User()
            
            user.userName = snapshotValue["name"]!
            user.userEmail = snapshotValue["email"]!
            user.userType = snapshotValue["type"]!
            user.userCompany = snapshotValue["company"]!
            user.userId = snapshot.key
            
            self.loggedUserInfoArray.append(user)
        }
    }
    
    
    //MARK: Load user contacts
    func loadUserContacts(){
        
        //Contatos do cliente
        Database.database().reference().child("users").queryOrdered(byChild: "type").queryEqual(toValue: "acao").observe(.childAdded) { (snapshot) in
            
            let snapshotValue = snapshot.value as! Dictionary<String, AnyObject>
            let contact = User()
            
            contact.userName = snapshotValue["name"]! as! String
            contact.userEmail = snapshotValue["email"]! as! String
            contact.userType = snapshotValue["type"]! as! String
            contact.userCompany = snapshotValue["company"]! as! String
            contact.userId = snapshot.key
            
            self.contactsArray.append(contact)
            self.tableView.reloadData()
            
        }
        
        //Contatos da empresa
        
        SVProgressHUD.dismiss()
    }
    
    //TODO: Escrever o bloco de nova conversa com novo contato
}
