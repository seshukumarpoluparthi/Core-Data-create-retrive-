//
//  ConTableViewCell.swift
//  pb1
//
//  Created by apple on 11/2/18.
//  Copyright © 2018 apple. All rights reserved.
//

import UIKit

class ConTableViewCell: UITableViewCell {
    
    
    @IBOutlet weak var contactName: UILabel!
    

    @IBOutlet weak var phoneNumber: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
