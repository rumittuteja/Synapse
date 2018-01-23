//
//  SurveyTableViewCell.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 12/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class SurveyTableViewCell: UITableViewCell {

    @IBOutlet weak var imgMsgType: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        imgMsgType.layer.cornerRadius = imgMsgType.frame.size.width / 2
        imgMsgType.layer.borderWidth = 3.0
        imgMsgType.layer.borderColor = UIColor.black.cgColor
        imgMsgType.layer.masksToBounds = true
        btnSurvey.layer.cornerRadius = 10.0
        // Initialization code
    }

    @IBOutlet weak var lblSurvey: UILabel!
    @IBOutlet weak var btnSurvey: UIButton!
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    func setSurveyDetails(forMessage message:Message!){
        lblSurvey.text = message.strText
    }

}
