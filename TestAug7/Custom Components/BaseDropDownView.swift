//
//  BaseDropDownView.swift
//  Profile
//
//  Created by Milan Katiyar on 24/07/19.
//  Copyright © 2019 learning. All rights reserved.
//

import Foundation
import UIKit
import DropDown
// weak var Delegate:BaseTextViewDelegate!
protocol BaseDropDownDelegate: class {
    
    func UpdateDropDownText(view: BaseDropDownView,index: Int,text: String)
}

public class BaseDropDownView : UIView {
    weak var Delegate:BaseDropDownDelegate!
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var dropDownView: UIView!
    @IBOutlet weak var dropDownLbl: UILabel!
    @IBOutlet weak var title_lbl: UILabel!
   let dropDown = DropDown()
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        initializeView()
        
    }
    
    func initializeView() {
        let podBundle = Bundle(for: BaseDropDownView.self)
        let nib = UINib(nibName: "BaseDropDownView", bundle: podBundle)
        mainView = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(mainView)
        mainView.frame = bounds
        mainView.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
     initializeDropDown()
    }
    
    func initializeDropDown(){
       
        dropDown.anchorView = dropDownView
        
      
        dropDown.direction = .any
        dropDown.bottomOffset = CGPoint(x: 0, y:(dropDown.anchorView?.plainView.bounds.height)!)
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            print("Selected item: \(item) at index: \(index)")
            self.dropDownLbl.text = item
            self.Delegate.UpdateDropDownText(view: self,index:index, text: item)
        }
       
    }
    
    public func setArrayForDropDown(listArray:Array<String>)  {
         let nameArray = listArray
     //   let sorted_name = nameArray.sorted { $0.localizedCaseInsensitiveCompare($1) == ComparisonResult.orderedAscending }
        dropDown.dataSource = nameArray
       // let nameArray = ["Milan", "Ajendra", "Farmood","Satish","Ranjeet"]
    }
    
    
    @IBAction func showDropDownView(_ sender: Any) {
       // dropDown.direction = .any
         self.dropDown.show()
        //initializeDropDown()
    }
}
