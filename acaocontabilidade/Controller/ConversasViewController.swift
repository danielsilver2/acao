//
//  ConversasViewController.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 24/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit
import Firebase

class ConversasViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{

    @IBOutlet weak var contactsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        contactsTableView.delegate = self
        contactsTableView.dataSource = self
        
    }
    
    //MARK: Table view configuration
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
         let cell = tableView.dequeueReusableCell(withIdentifier: "conversasTableViewCell", for: indexPath) as! ConversasTableViewCell
        
        let contactsArray = ["Financeiro", "Societário", "Contábil"]
        
        cell.contactName.text = contactsArray[indexPath.row]
        
        return cell
        
    }

}
