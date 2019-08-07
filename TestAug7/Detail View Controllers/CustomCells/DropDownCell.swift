//
//  DropDownCell.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/26/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit

class DropDownCell: UITableViewCell {

    @IBOutlet weak var dropDownBView: BaseDropDownView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
