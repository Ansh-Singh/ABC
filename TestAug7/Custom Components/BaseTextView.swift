//
//  BaseTextView.swift
//  Profile
//
//  Created by Milan Katiyar on 23/07/19.
//  Copyright © 2019 learning. All rights reserved.
//

import Foundation
import UIKit
// weak var Delegate:BaseTextViewDelegate!
protocol BaseTextViewDelegate: class {
    
    func UpdateBaseText(view: BaseTextView,text: String)
}

public class BaseTextView : UIView {
    @IBOutlet weak var sView: UIView!
    weak var Delegate:BaseTextViewDelegate!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var generic_textField: UITextField!
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView() {
        let podBundle = Bundle(for: BaseTextView.self)
        let nib = UINib(nibName: "BaseTextView", bundle: podBundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        generic_textField.delegate = self
        sView.layer.borderColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1).cgColor
        sView.layer.borderWidth = 1
        
    }
  
}

extension BaseTextView: UITextFieldDelegate {

    public func textFieldDidBeginEditing(_ textField: UITextField) {
        
    }
    public func textFieldDidEndEditing(_ textField: UITextField) {
        Delegate.UpdateBaseText(view: self, text: textField.text ?? "no text")
    }
}
