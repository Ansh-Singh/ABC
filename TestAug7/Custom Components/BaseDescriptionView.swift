//
//  BaseDescriptionView.swift
//  Profile
//
//  Created by Milan Katiyar on 23/07/19.
//  Copyright © 2019 learning. All rights reserved.
//

import Foundation
import UIKit

public class BaseDescriptionView: UIView {
   
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var desription_detailLbl: UILabel!
    @IBOutlet weak var desription_detailTextView: UITextView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        let podBundle = Bundle(for: BaseTextView.self)
        let nib = UINib(nibName: "BaseDescriptionView", bundle: podBundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
    }
}
