//
//  DateTextFieldCell.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/26/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit

class DateTextFieldCell: UITableViewCell {
    @IBOutlet weak var View_date: BaseTextViewWithDate!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
