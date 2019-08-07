//
//  BaseTextViewWithDate.swift
//  Profile
//
//  Created by Milan Katiyar on 23/07/19.
//  Copyright © 2019 learning. All rights reserved.

import Foundation
import UIKit
protocol BaseDateViewDelegate: class {
    
    func UpdateDateBaseText(view: BaseTextViewWithDate,text: String)
}

public class BaseTextViewWithDate : UIView {
     @IBOutlet weak var sView: UIView!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var title_lbl: UILabel!
    @IBOutlet weak var generic_textField: UITextField!
    weak var Delegate:BaseDateViewDelegate!
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
    }
    
    func initializeView(){
        let podBundle = Bundle(for: BaseTextViewWithDate.self)
        let nib = UINib(nibName: "BaseTextViewWithDate", bundle: podBundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
      
        let picker : UIDatePicker = UIDatePicker()
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(dueDateChanged), for: .valueChanged)
        generic_textField.inputView = picker
        generic_textField.delegate = self
        sView.layer.borderColor = UIColor(red: 239.0/255.0, green: 239.0/255.0, blue: 244.0/255.0, alpha: 1).cgColor
        sView.layer.borderWidth = 1
        
    }
    
    @IBAction func calendarClicked(_ sender: Any) {
       generic_textField.becomeFirstResponder()
    }
    @objc func dueDateChanged(sender: UIDatePicker){
        
            generic_textField.text = DateUtil.convertDateToString(date: sender.date, reqFormat: DateUtil.AMADEUS_DATE)
        
        }
}
extension BaseTextViewWithDate : UITextFieldDelegate {

    public func textFieldDidEndEditing(_ textField: UITextField) {
        if textField.text?.count ?? 0 < 1 {
              let txt = DateUtil.convertDateToString(date: Date(), reqFormat: DateUtil.AMADEUS_DATE)
             Delegate.UpdateDateBaseText(view: self, text: txt)
            self.generic_textField.text = txt
        }
        else {
        Delegate.UpdateDateBaseText(view: self, text: textField.text ?? "no text")
        }
    }
}

