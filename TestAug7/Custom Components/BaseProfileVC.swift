//
//  BaseProfileVC.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/22/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit
import Alamofire

class BaseProfileVC: UIViewController {
    @IBOutlet weak var basicViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerViewP: ProfileHeader!
     @IBOutlet weak var noDataFoundView: UIView!
     @IBOutlet weak var noDataFound_label: UILabel!
    override func viewDidLoad() {
         super.viewDidLoad()
        if headerViewP == nil {
            
        }
        else {
       // headerViewP.setProfileImages(imageName: "farmood.jpg")
        headerViewP.plusBtb.addTarget(self, action: #selector(setBasicInfoOpenClose(btn:)), for: .touchUpInside)
        }
        
        if noDataFound_label != nil {
            noDataFound_label.text = noDataTxt_account
        }
       
      //  headerViewP.setBasicHeight(height: 0)
       // basicViewHeight.constant = 185
        
    }
    @objc func setBasicInfoOpenClose(btn: UIButton) {
        if btn.isSelected == true {
             btn.isSelected = false
            headerViewP.setBasicHeight(height: 185)
            basicViewHeight.constant = 395
        }
        else {
             btn.isSelected = true
            headerViewP.setBasicHeight(height: 0)
            basicViewHeight.constant = 185
            
        }
    
       
    }
    
    func removePassportew(type: String,recordId: String,success: @escaping(String) -> Void) {
        
    }
    func removePassport(type: String,recordId: String,success: @escaping(Bool) -> Void) {
                var params: Parameters = [:]
                params["ORG_ID"] = "93"
                params["LOCATION_ID"] = "66"
                params["TOKEN"] = "92b2ae6292946dcd6caee78496d98065"
                params["SIGNIN_TYPE"] = "P"
                params["RECORD_TYPE"] = type
                params["RECORD_ID"] = recordId
        
        let postParamHeaders = [String: String]()
        
        ServerCommunication.getDataWithGetWithDataResponse(url: "deteleProfileData", parameter: params, HeaderParams: postParamHeaders, methodType:.post, viewController: self, success: { (successResponseData) in
            
            success(true)
            /*
                        if let dictFailure = successResponseData.result.value as? [String: AnyObject]{
                            
                            if let msg = dictFailure["message"] as? String
                            {
                                
                                DataUtil.alertMessage(msg , viewController: self)
                            }
                        }
                    */
            
                
            
            
        }) { (dictFailure) in
            if let msg = dictFailure.value(forKey: "message"){
                
                DataUtil.alertMessage(msg as! String, viewController: self)
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
