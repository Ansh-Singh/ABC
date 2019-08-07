//
//  AddressGeoCell.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 8/5/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit

class AddressGeoCell: UITableViewCell {
    @IBOutlet weak var addressView: BaseAddressView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
