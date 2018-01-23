//
//  OptionTableViewCell.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/22/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class OptionTableViewCell: UITableViewCell {

    @IBOutlet weak var lblBackView: UIView!
    @IBOutlet weak var lblOption: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        lblBackView.layer.cornerRadius = 10.0
        
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
