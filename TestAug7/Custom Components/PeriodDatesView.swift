//
//  PeriodDatesView.swift
//  Profile
//
//  Created by Milan Katiyar on 23/07/19.
//  Copyright © 2019 learning. All rights reserved.
//

import Foundation
import UIKit
protocol BasePeriodDateDelegate: class {
    
    func UpdatePeriodDateText(view: PeriodDatesView,text: String,IndexDate: Int)
}
public class PeriodDatesView : UIView {
      weak var Delegate:BasePeriodDateDelegate!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var startDate_lbl: UILabel!
    @IBOutlet weak var endDate_lbl: UILabel!
    @IBOutlet weak var startDate_textField: UITextField!
    @IBOutlet weak var endDate_textField: UITextField!
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
        startDate_textField.tag = 1
        endDate_textField.tag = 2
        startDate_textField.delegate = self
        endDate_textField.delegate = self
        
    }
    
    func initializeView() {
        let podBundle = Bundle(for: PeriodDatesView.self)
        let nib = UINib(nibName: "PeriodDatesView", bundle: podBundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
       
                openstartdate()
                openEndDate()
    }
    
    @IBAction func startDate_calendarClicked(_ sender: Any) {
        startDate_textField.becomeFirstResponder()
    }
    
    @IBAction func endDate_calendarClicked(_ sender: Any) {
        endDate_textField.becomeFirstResponder()
      
    }
    
    func openstartdate(){
        let picker : UIDatePicker = UIDatePicker()
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(startDateChanged), for: .valueChanged)
        startDate_textField.inputView = picker
    }
    
    func openEndDate() {
        let picker : UIDatePicker = UIDatePicker()
        picker.datePickerMode = UIDatePicker.Mode.date
        picker.backgroundColor = .white
        picker.addTarget(self, action: #selector(endDateChanged), for: .valueChanged)
        endDate_textField.inputView = picker
    }
    
    @objc func startDateChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        startDate_textField.text = dateFormatter.string(from: sender.date)
    }
    
    @objc func endDateChanged(sender: UIDatePicker){
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .long
        dateFormatter.timeStyle = .medium
        endDate_textField.text = dateFormatter.string(from: sender.date)
    }
}
extension PeriodDatesView : UITextFieldDelegate {
    public func textFieldDidEndEditing(_ textField: UITextField) {
        Delegate.UpdatePeriodDateText(view: self, text: textField.text ?? "no text",IndexDate:textField.tag)
    }
}
