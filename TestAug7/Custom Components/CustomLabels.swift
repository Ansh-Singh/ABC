//
//  CustomLabels.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/24/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit

class blueTitleLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure(){
        
     //   self.font = UIFont(name:"Roboto-Regular", size: 14.0)
        
        self.textColor = UIColor(red: 16.0/255.0, green: 90.0/255.0, blue: 168.0/255.0, alpha: 1)
        
        
        //  self.backgroundColor = UIColor(red: 69.0/255.0, green: 159.0/255.0, blue: 134.0/255.0, alpha: 1)
        
        
    }
    
    
}
class lightGrayTitleLabel: UILabel {
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure(){
        
        //   self.font = UIFont(name:"Roboto-Regular", size: 14.0)
        
        self.textColor = UIColor(red: 239.0/255.0, green: 240.0/255.0, blue: 239.0/255.0, alpha: 1)
        
        
        //  self.backgroundColor = UIColor(red: 69.0/255.0, green: 159.0/255.0, blue: 134.0/255.0, alpha: 1)
        
        
    }
    
    
}

class RoundView: UIView {
   // self.layer.borderColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1).cgColor
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure(){
    //self.layer.borderWidth = 1
    self.layer.cornerRadius = 5
     //   self.layer.borderColor = UIColor.clear.cgColor
    }
}

