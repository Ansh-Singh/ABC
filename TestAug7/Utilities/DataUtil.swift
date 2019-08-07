//
//  DataUtil.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/23/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit
import MBProgressHUD


class DataUtil: NSObject {
    static func getFullName(firstname : String,middlename : String,lastname : String) -> String {
        
        var nameStr = firstname
        
        if firstname.count > 0 && middlename.count > 0 && lastname.count > 0 {
            nameStr = firstname + " " + middlename + " " + lastname
            
        }
        else if firstname.count > 0 && middlename.count < 1 && lastname.count > 0  {
            nameStr = firstname + " " + lastname
        }
        else if firstname.count > 0 && middlename.count > 0 && lastname.count < 1  {
            nameStr = firstname + " " + middlename
        }
        
        
        
        return nameStr
    }
    // Screen width.
   class public var screenWidth: CGFloat {
        return UIScreen.main.bounds.width
    }
    
    // Screen height.
    class public var screenHeight: CGFloat {
        return UIScreen.main.bounds.height
    }
    
    class func ShowIndictorView(IndicatoreTitle: String)  {
        let appdel = UIApplication.shared.delegate as! AppDelegate
        let hud =  MBProgressHUD.showAdded(to: appdel.window!, animated: true) as MBProgressHUD
        
        hud.labelText = IndicatoreTitle
        // MBProgressHUD.labelT
    }
    
    class func HideIndictorView()  {
        let appdel = UIApplication.shared.delegate as! AppDelegate
        MBProgressHUD.hide(for: appdel.window!, animated: true)
        //   MBProgressHUD.showAdded(to: self.window, animated: true)
        
        
    }
    class func alertMessage (_ msgString : String,viewController: UIViewController)
    {
        let alert = UIAlertController(title: "" , message: msgString, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        viewController.present(alert, animated: true, completion: nil)
    }
}

class BorderView: UIView {
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    func configure(){
        self.layer.cornerRadius = 2
        self.clipsToBounds = true
        self.layer.shadowOffset = CGSize(width: 0, height: 8)
        
        self.layer.shadowOpacity = 1
        self.layer.shadowRadius = 18
        self.layer.shadowColor = UIColor(red:0, green:0, blue:0, alpha:0.25).cgColor
        self.layer.borderWidth = 1
        self.layer.borderColor = UIColor.lightGray.cgColor
        
    }
    
    
}
