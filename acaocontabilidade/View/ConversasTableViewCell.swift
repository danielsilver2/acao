//
//  ConversasTableViewCell.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 24/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit

class ConversasTableViewCell: UITableViewCell {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var contactImg: UIImageView!
    @IBOutlet weak var statusLbl: UILabel!
    
    //MARK: Date & Time variables
    var date = Date()
    let calendar = Calendar.current
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func configureCell(name: String){
        contactName.text = name
        
        if contactName.text == "Societário"{
            contactImg.image = #imageLiteral(resourceName: "handshake")
        }else if contactName.text == "Contábil"{
            contactImg.image = #imageLiteral(resourceName: "calculator")
        }else if contactName.text == "Financeiro"{
            contactImg.image = #imageLiteral(resourceName: "combo_chart")
        }else if contactName.text == "Pessoal"{
            contactImg.image = #imageLiteral(resourceName: "businessman")
        }else if contactName.text == "Fiscal"{
            contactImg.image = #imageLiteral(resourceName: "checked")
        }else{
            contactImg.image = #imageLiteral(resourceName: "acao_logo")
        }
   
    }
    
}
