//
//  QuestionTableViewCell.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/22/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {
    @IBOutlet weak var imgStatus: UIImageView!

    @IBOutlet weak var imgMsgType: UIImageView!
    @IBOutlet weak var questionBackView: UIView!
    @IBOutlet weak var lblQuestion: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        self.accessibilityHint = "ClassHint"
        imgMsgType.layer.cornerRadius = imgMsgType.frame.size.width / 2
        imgMsgType.layer.borderWidth = 3.0
        imgMsgType.layer.borderColor = UIColor.black.cgColor
        imgMsgType.layer.masksToBounds = true
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setInformation(forMessage message:Message!){
        lblQuestion.text = message.strText
    }
}
