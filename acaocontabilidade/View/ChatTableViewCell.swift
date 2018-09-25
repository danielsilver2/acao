//
//  ChatTableViewCell.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 25/07/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit

class ChatTableViewCell: UITableViewCell {

    @IBOutlet weak var receivedMessageText: UILabel!
    @IBOutlet weak var sentMessageText: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
