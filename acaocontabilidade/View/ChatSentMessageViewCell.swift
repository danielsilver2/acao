//
//  ChatSentMessageViewCell.swift
//  acaocontabilidade
//
//  Created by Miguel Asipavicins on 05/09/2018.
//  Copyright © 2018 penseapp. All rights reserved.
//

import UIKit

class ChatSentMessageViewCell: UITableViewCell {
    @IBOutlet weak var bubbleView: UIView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        bubbleView.layer.cornerRadius = bubbleView.frame.height / 2
    }
}
