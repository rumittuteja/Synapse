//
//  ReminderTableViewCell.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 12/10/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class ReminderTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMsgType: UIImageView!
    @IBOutlet weak var imgStatus: UIImageView!
    @IBOutlet weak var reminderBackView: UIView!
    @IBOutlet weak var lblReminder: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMsgType.layer.cornerRadius = imgMsgType.frame.size.width / 2
        imgMsgType.layer.borderWidth = 3.0
        imgMsgType.layer.borderColor = UIColor.black.cgColor
        imgMsgType.layer.masksToBounds = true
//        reminderBackView.layer.borderWidth = 2.0
//        reminderBackView.layer.borderColor = UIColor.red.cgColor

        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setReminder(forMessage message:Message!){
        lblReminder.text = message.strText
    }
}
