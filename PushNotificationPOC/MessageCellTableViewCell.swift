//
//  MessageCellTableViewCell.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/15/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class MessageCellTableViewCell: UITableViewCell {

    @IBOutlet weak var lblYourChoice: UILabel!
    @IBOutlet weak var lblMessageText: UILabel!
    @IBOutlet weak var lblMessageType: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func populateCell(withMessage objMessage:Message){
        self.lblMessageText.text = objMessage.strText!
        self.lblMessageType.text = objMessage.strType!
        if let selectedOutcome = objMessage.strSelectedOutcome, let _ = objMessage.strSelectedOutcome?.characters.count {
            self.lblYourChoice.text = selectedOutcome
        }else{
            self.lblYourChoice.text = "CLick here to answer"
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
}
