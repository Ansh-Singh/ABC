//
//  ProfileHeader.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/22/19.
//  Copyright © 2019 learning. All rights reserved.
// https://stackoverflow.com/questions/28501010/add-a-custom-color-palette-to-xcode-interface-builder

import UIKit

  public class ProfileHeader: UIView {
    
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblDesignation: UILabel!
    @IBOutlet weak var lblTemType: UILabel!
    @IBOutlet weak var lblEmpId: UILabel!
    @IBOutlet weak var lblDoj: UILabel!
    
    @IBOutlet weak var lblEmail: UILabel!
    @IBOutlet weak var lblDob: UILabel!
    @IBOutlet weak var lblAddress: UILabel!
    @IBOutlet weak var lblGender: UILabel!
    @IBOutlet weak var lblMobile: UILabel!
    @IBOutlet weak var lblEmergencyCont: UILabel!
    
    @IBOutlet weak var basicInfoView: UIView!
    @IBOutlet weak var plusBtb: UIButton!
    @IBOutlet weak var basicViewHeight: NSLayoutConstraint!
    @IBOutlet fileprivate var  profImgview: UIImageView!
    public var basicInfo:UserBasicInfo?
  @IBOutlet fileprivate var mView: UIView!
   fileprivate var view:UIView!
    
    required public init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        loadView()
    }
    func loadView() {
    
        let podBundle = Bundle(for: ProfileHeader.self)
        let nib = UINib(nibName: "ProfileHeader", bundle: podBundle)
        view = nib.instantiate(withOwner: self, options: nil)[0] as? UIView
        self.addSubview(view)
        view.frame = bounds
        view.autoresizingMask = [UIView.AutoresizingMask.flexibleWidth, UIView.AutoresizingMask.flexibleHeight]
        mView.backgroundColor = cellColor
        if let userD = basicInfoG {
            self.basicInfo = userD
            self.setValues(userData: userD)
        }
        
        profImgview.layer.borderWidth = 1.0
        profImgview.layer.masksToBounds = false
        //        profImgview.layer.borderColor = .gra
        profImgview.layer.cornerRadius = profImgview.frame.size.width / 2
        profImgview.clipsToBounds = true
    }
    
    public func setBasicHeight(height:CGFloat){
        if height < 1 {
            basicInfoView.isHidden = true
        }
        else {
            basicInfoView.isHidden = false
        }
         basicViewHeight.constant = height
        
    }
    public func setValues(userData: UserBasicInfo) {
        if let fname = userData.FNAME, let mname = userData.MNAME, let lname = userData.LNAME {
           self.lblName.text = DataUtil.getFullName(firstname: fname, middlename: mname, lastname: lname)
        }
        if let email = userData.EMAIL {
            self.lblEmail.text = email
        }
        if let empId = userData.EMPLOYEE_NUMBER {
            self.lblEmpId.text = empId
        }
        if let dob = userData.DOB {
            self.lblDob.text = dob
        }
        if let mobile = userData.MOBILE_NO {
            self.lblMobile.text = mobile
        }
        if let dob = userData.DATE_OF_JOIN {
            self.lblDoj.text = dob
        }
        if let dob = userData.TEAM_NAME {
            self.lblTemType.text = dob
        }
        if let dob = userData.USER_TYPE {
            self.lblDesignation.text = dob
        }
        if let imgUrl = userData.PROFILE_IMAGE {
            guard let url = URL(string: imgUrl) else { return  }
            let data = try? Data(contentsOf: url)
            
            if let imageData = data {
                let image = UIImage(data: imageData)
                self.profImgview.image = image
            }
            
        }

    }
}



