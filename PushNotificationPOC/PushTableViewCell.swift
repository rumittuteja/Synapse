//
//  PushTableViewCell.swift
//  PushNotificationPOC
//
//  Created by Swati Jha on 11/30/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class PushTableViewCell: UITableViewCell {

    @IBOutlet weak var switchP: UISwitch!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
