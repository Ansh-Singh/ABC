//
//  ProfileListVC.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/31/19.
//  Copyright © 2019 learning. All rights reserved.

import UIKit
import Alamofire

class ProfileListVC: BaseProfileVC {
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var footrView: UIView!
    var obj_lookUpType: ProfileLookupType?
    var arrValueArray = [String]()
    var attributArray = [AttributeForm]()
    var attributArrayClone = [AttributeFormClone]()
    var detailArray = [DetailListProfile]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let obj = obj_lookUpType {
            self.title = obj.LOOKUP_TYPE ?? ""
        }
        self.tblView.tableFooterView = footrView
        super.viewDidLoad()
        for _ in 0...62 {
            arrValueArray.append("")
        }
        headerViewP.setBasicHeight(height: 0)
        basicViewHeight.constant = 185
        headerViewP.plusBtb.isSelected = true
        tblView.isHidden = true
        self.tblView.rowHeight = UITableViewAutomaticDimension;
        self.tblView.estimatedRowHeight = 200;
        let button1 = UIBarButtonItem(image: UIImage(named: "plus_icon"), style: .plain, target: self, action: #selector(addNewClicked)) // action:#selector(Class.MethodName) for swift 3
        self.navigationItem.rightBarButtonItem  = button1
        
        self.getData()
        // Do any additional setup after loading the view.
    }
    
    
    func isValidate() -> Bool {
        for item in self.attributArray {
            if item.PROFILE_ATTRIBUTE_REQUIRED == "Y" {
                if let text = item.PROFILE_ATTRIBUTE_DEFAULT_VALUE, let desc = item.PROFILE_ATTRIBUTE_DESCRIPTION {
                    
                    if text.count < 1 {
                        DataUtil.alertMessage("Please enter \(desc)", viewController: self)
                        
                        return false
                        
                    }
                    
                }
                else {
                    DataUtil.alertMessage("Please enter \(item.PROFILE_ATTRIBUTE_DESCRIPTION!)", viewController: self)
                    return false
                }
                
                
            }
            
            
        }
        
        
        return true
    }
    @objc func addNewClicked() {
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        let obj = story.instantiateViewController(withIdentifier: "ListViewForAllVC") as! ListViewForAllVC
        
        obj.obj_lookUpType = self.obj_lookUpType
        obj.attributArrayClone = self.attributArrayClone
        obj.delegateUpdate = self
        self.present(obj, animated: true, completion: nil)
       // self.navigationController?.pushViewController(obj, animated: true)
        
    }
    func getData(){
        
        
        if let obj = obj_lookUpType {
            
            // "LOOKUP_FLAG":"X", "SYSTEM_ID":"T", "SIGNIN_TYPE":"P"
            let params:Parameters =  ["LOOKUP_TYPE_ID": obj.LOOKUP_TYPE_ID ?? ""]
            
            let postParamHeaders = [String: String]()
            
            ServerCommunication.getDataWithGetWithDataResponse(url: "hrProfileAttributes", parameter: params, HeaderParams: postParamHeaders, methodType: .post, viewController: self, success: { (successResponseData) in
                self.tblView.isHidden = false
                if let cryptoData = successResponseData.data {
                    
                    do {
                        let decoder = JSONDecoder()
                        
                        let serviceResponse = try decoder.decode(AttributProfileData.self, from: cryptoData)
                        if serviceResponse.success == true {
                        if var types = serviceResponse.data?.ATTRIBUTES {
                                self.attributArray = types
                            
            for item in self.attributArray {
                let objClone = AttributeFormClone()
                objClone.LOOKUP_TYPE_ID = item.LOOKUP_TYPE_ID
                objClone.PROFILE_ATTRIBUTE_ID = item.PROFILE_ATTRIBUTE_ID
                
                objClone.HR_PROFILE_ATTRIBUTE_ID = item.HR_PROFILE_ATTRIBUTE_ID
                objClone.PROFILE_ATTRIBUTE_DESCRIPTION = item.PROFILE_ATTRIBUTE_DESCRIPTION
                objClone.PROFILE_ATTRIBUTE_TYPE = item.PROFILE_ATTRIBUTE_TYPE
                objClone.PROFILE_ATTRIBUTE_SIZE = item.PROFILE_ATTRIBUTE_TYPE
                objClone.PROFILE_ATTRIBUTE_DEFAULT_VALUE = item.PROFILE_ATTRIBUTE_DEFAULT_VALUE
                objClone.PROFILE_ATTRIBUTE_REQUIRED = item.PROFILE_ATTRIBUTE_REQUIRED
                objClone.PROFILE_ATTRIBUTE_SEQUENCE = item.PROFILE_ATTRIBUTE_SEQUENCE
                objClone.PROFILE_ATT_LOOKUP_SOURCE = item.PROFILE_ATT_LOOKUP_SOURCE
                objClone.PROFILE_ATT_LOOKUP_FILTER_ID = item.PROFILE_ATT_LOOKUP_FILTER_ID
                objClone.PROFILE_ATTRIBUTE_DEFAULT_LOOKUP_ID = item.PROFILE_ATTRIBUTE_DEFAULT_LOOKUP_ID
                objClone.PROFILE_ATTRIBUTE_GEO_LEVEL = item.PROFILE_ATTRIBUTE_GEO_LEVEL
                objClone.PROFILE_ATTTRIBUTE_HELP_ID = item.PROFILE_ATTTRIBUTE_HELP_ID
                objClone.PROFILE_ATTRIBUTE_HIDE_VALUE = item.PROFILE_ATTRIBUTE_HIDE_VALUE
                objClone.PROFILE_ATTRIBUTE_HIDE_VALUE = item.PROFILE_ATTRIBUTE_HIDE_VALUE
                objClone.ADDITIONAL_ATTRIBUTES = item.ADDITIONAL_ATTRIBUTES
                self.attributArrayClone.append(objClone)
                                }
                                
                            }
                            if let detail = serviceResponse.data?.DETAIL {
                                self.detailArray = detail
                                self.tblView.reloadData()
                                }
                        }
                        else {
                            
                            
                            if let dictFailure = successResponseData.result.value as? [String: AnyObject]{
                                
                                if let msg = dictFailure["message"] as? String
                                {
                                    
                                    DataUtil.alertMessage(msg , viewController: self)
                                }
                            }
                        }
 
                        if self.detailArray.count < 1 {
                            self.noDataFoundView.isHidden = false
                        }
                        else {
                            self.noDataFoundView.isHidden = true
                        }
                        
                    } catch let jsonError {
                        print("jsonError ===",jsonError)
                    }
                    
                    
                    
                    
                }
                else {
                    
                    
                    
                }
                
            }) { (dictFailure) in
                if let msg = dictFailure.value(forKey: "message"){
                    
                    DataUtil.alertMessage(msg as! String, viewController: self)
                }
            }
        }
    }
    @objc func openOptionsforCell(btn: UIButton) {
        let objDetailProfile = self.detailArray[btn.tag]
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title:"Edit", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            
            let story = UIStoryboard(name: "Main", bundle: nil)
            
            let obj = story.instantiateViewController(withIdentifier: "ListViewForAllVC") as! ListViewForAllVC
                var i = 0
            for item in self.attributArray {
                if objDetailProfile.LIST != nil && i < objDetailProfile.LIST!.count {
                  let arr =  objDetailProfile.LIST?.filter({ $0.PROFILE_ATTRIBUTE_ID! == item.PROFILE_ATTRIBUTE_ID! })
                    
                    if arr != nil && arr!.count > 0 {
                        item.HR_PROFILE_ATTRIBUTE_ID = arr?[0].HR_PROFILE_ATTRIBUTE_ID
                        item.PROFILE_ATTRIBUTE_DEFAULT_VALUE = arr?[0].VALUE
                        item.LOOKUP_ID = arr?[0].LOOKUP_ID
                        
                    }
                }
               i = i + 1
            }
            
            obj.dataSetId = objDetailProfile.LIST_ID
            obj.obj_lookUpType = self.obj_lookUpType
            obj.attributArray = self.attributArray
            obj.delegateUpdate = self
            
            self.present(obj, animated: true, completion: nil)
            
        }))
        alert.addAction(UIAlertAction(title:"Delete", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            if let recordId = objDetailProfile.LIST_ID {
                
                self.deleteProfileData(recordId: recordId, index: btn.tag)
                /*
                
                self.removePassport(type: "PASSPORT", recordId: recordId, success: { (str) in
                    
                    self.detailArray.remove(at: btn.tag)
                    self.tblView.reloadData()
                    if self.detailArray.count < 1 {
                        self.noDataFoundView.isHidden = false
                    }
                    else {
                        self.noDataFoundView.isHidden = true
                    }
                    
                })
                */
            }
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: UIAlertAction.Style.cancel, handler: { (action: UIAlertAction!) in
        }))
        if ( UI_USER_INTERFACE_IDIOM() == UIUserInterfaceIdiom.pad ){
            if let popoverController = alert.popoverPresentationController {
                popoverController.sourceView = self.view
                popoverController.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.maxY-60, width: 0, height: 0)
                popoverController.permittedArrowDirections = UIPopoverArrowDirection.down;
            }
        }
        present(alert, animated: true, completion: nil)
        
    }
    func deleteProfileData(recordId: String, index: NSInteger) {
        if let obj = obj_lookUpType {
            let params:Parameters =  ["LOOKUP_TYPE_ID": obj.LOOKUP_TYPE_ID ?? "", "DATASET_ID": recordId]
            let postParamHeaders = [String: String]()
        ServerCommunication.getDataWithGetWithDataResponse(url: "deteleProfileData", parameter: params, HeaderParams: postParamHeaders, methodType: .post, viewController: self, success: { (successResponseData) in
                self.tblView.isHidden = false
                if let cryptoData = successResponseData.data {
     
                    if let json = successResponseData.result.value as? NSDictionary {
                        
                        if let succ = json["success"] as? Bool {
                            
                            if succ == true {
                                self.detailArray.remove(at: index)
                                self.tblView.reloadData()
                                if self.detailArray.count < 1 {
                                    self.noDataFoundView.isHidden = false
                                }
                                else {
                                    self.noDataFoundView.isHidden = true
                                }
                            }
                            else {
                                if let data = json["data"] as? NSDictionary {
                                    let msg = data["message"] as! String
                                    DataUtil.alertMessage(msg, viewController: self)
                                }
                           }
                        }
                    }
                    
                }
                else {
                }
            
            }) { (dictFailure) in
                if let msg = dictFailure.value(forKey: "message"){
                    
                    DataUtil.alertMessage(msg as! String, viewController: self)
                }
            }
        }
    }
}
extension ProfileListVC: UITableViewDataSource, UITableViewDelegate,updateProfileListData{
    func updateListData(attributArray: [AttributeForm],listId: String, isUpdate: Bool) {
        if isUpdate == true {
            //let obj = DetailListProfile()
           // obj.LIST_ID = listId
           // let LIST = [ListData]()
          let arr = self.detailArray.filter({$0.LIST_ID! == listId})
            if arr.count > 0 {
                var i = 0
                let listarr = arr[0].LIST!
                for item in listarr {
                    let arrAttribute = self.attributArray.filter({$0.PROFILE_ATTRIBUTE_ID! == item.PROFILE_ATTRIBUTE_ID!})
                    if arrAttribute.count > 0 {
                       item.VALUE = arrAttribute[0].PROFILE_ATTRIBUTE_DEFAULT_VALUE
                        item.PROFILE_ATTRIBUTE_ID = arrAttribute[0].PROFILE_ATTRIBUTE_ID
                        
                    }
                    
                    i = i + 1
                }
            }
            /*
            for item in attributArray {
                let listData = ListData()
                listData.TITLE = item.PROFILE_ATTRIBUTE_DESCRIPTION
                listData.VALUE = item.PROFILE_ATTRIBUTE_DEFAULT_VALUE
                listData.TYPE = item.PROFILE_ATTRIBUTE_TYPE
                LIST.append(listData)
            }
            */
           // obj.LIST = LIST
           // self.detailArray.append(obj)
            self.tblView.reloadData()
            self.tblView.setContentOffset(.zero, animated: true)
        }
        else {
            let obj = DetailListProfile()
            obj.LIST_ID = listId
            var LIST = [ListData]()
            for item in attributArray {
                let listData = ListData()
                listData.TITLE = item.PROFILE_ATTRIBUTE_DESCRIPTION
                listData.VALUE = item.PROFILE_ATTRIBUTE_DEFAULT_VALUE
                listData.TYPE = item.PROFILE_ATTRIBUTE_TYPE
                 listData.HR_PROFILE_ATTRIBUTE_ID = item.HR_PROFILE_ATTRIBUTE_ID
                listData.PROFILE_ATTRIBUTE_ID = item.PROFILE_ATTRIBUTE_ID
                
                LIST.append(listData)
            }
            obj.LIST = LIST
            self.detailArray.append(obj)
            self.tblView.reloadData()
            self.tblView.setContentOffset(.zero, animated: true)
        }
        
        if self.detailArray.count < 1 {
            self.noDataFoundView.isHidden = false
        }
        else {
            self.noDataFoundView.isHidden = true
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return detailArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    
            let cell = tableView.dequeueReusableCell(withIdentifier: "ProfileListCell") as! ProfileListCell
            let obj = self.detailArray[indexPath.row]
             cell.setPassportInfoData(obj)
        cell.btnthreeDots.tag = indexPath.row
        cell.btnthreeDots.addTarget(self, action: #selector(openOptionsforCell(btn:)), for: .touchUpInside)
        return cell
            return cell
      
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        var height: CGFloat = 40 + 20
        if let list = self.detailArray[indexPath.row].LIST{
            for item in list {
                height = height + 29
            }
            
        }
        else {
            height = height + 29
        }
        return height
    }
 
}

class ProfileListCell: UITableViewCell {
    
    @IBOutlet weak var sViewHeight: NSLayoutConstraint!
    @IBOutlet weak var btnthreeDots: UIButton!
    @IBOutlet weak var lbl1: UILabel!
    @IBOutlet weak var lbl2: UILabel!
    @IBOutlet weak var lbl3: UILabel!
    @IBOutlet weak var lbl4: UILabel!
    @IBOutlet weak var lbl5: UILabel!
    @IBOutlet weak var lbl6: UILabel!
    @IBOutlet weak var lbl7: UILabel!
    @IBOutlet weak var lbl8: UILabel!
    @IBOutlet weak var lbl9: UILabel!
    @IBOutlet weak var lbl10: UILabel!
    @IBOutlet weak var lbl11: UILabel!
    @IBOutlet weak var lbl12: UILabel!
    @IBOutlet weak var lbl13: UILabel!
    @IBOutlet weak var lbl14: UILabel!
    @IBOutlet weak var lbl15: UILabel!
    
    @IBOutlet weak var lblTitle1: UILabel!
    @IBOutlet weak var lblTitle2: UILabel!
    @IBOutlet weak var lblTitle3: UILabel!
    @IBOutlet weak var lblTitle4: UILabel!
    @IBOutlet weak var lblTitle5: UILabel!
    @IBOutlet weak var lblTitle6: UILabel!
    @IBOutlet weak var lblTitle7: UILabel!
    @IBOutlet weak var lblTitle8: UILabel!
    @IBOutlet weak var lblTitle9: UILabel!
    @IBOutlet weak var lblTitle10: UILabel!
    @IBOutlet weak var lblTitle11: UILabel!
    @IBOutlet weak var lblTitle12: UILabel!
    @IBOutlet weak var lblTitle13: UILabel!
    @IBOutlet weak var lblTitle14: UILabel!
    @IBOutlet weak var lblTitle15: UILabel!
    
  //  var passportInfoList:PassportList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setPassportInfoData(_ detilListInfo: DetailListProfile) {
        
        if let list = detilListInfo.LIST {
            var i = 0
        for item in list {
            if i == 0 {
             
                 self.lblTitle1.text = item.TITLE ?? ""
                  self.lbl1.text = item.VALUE ?? ""
                
            }
            if i == 1 {
               
                    self.lblTitle2.text = item.TITLE ?? ""
                    self.lbl2.text = item.VALUE ?? ""
                
            }
            if i == 2 {
                
                    self.lblTitle3.text = item.TITLE ?? ""
                    self.lbl3.text = item.VALUE ?? ""
                
            }
            if i == 3 {
             
                    self.lblTitle4.text = item.TITLE ?? ""
                    self.lbl4.text = item.VALUE ?? ""
                
            }
            if i == 4 {
              
                    self.lblTitle5.text = item.TITLE ?? ""
                    self.lbl5.text = item.VALUE ?? ""
                
            }
            if i == 5 {
               
                    self.lblTitle6.text = item.TITLE ?? ""
                    self.lbl6.text = item.VALUE ?? ""
                
            }
            if i == 6 {
                    self.lblTitle7.text = item.TITLE ?? ""
                    self.lbl7.text = item.VALUE ?? ""
                
            }
            if i == 7 {
            
                    self.lblTitle8.text = item.TITLE ?? ""
                    self.lbl8.text = item.VALUE ?? ""
                
            }
            if i == 8 {
              
                    self.lblTitle9.text = item.TITLE ?? ""
                    self.lbl9.text = item.VALUE ?? ""
                
            }
            if i == 9 {
               
                    self.lblTitle10.text = item.TITLE ?? ""
                    self.lbl10.text = item.VALUE ?? ""
                
            }
            if i == 10 {
                
                    self.lblTitle11.text = item.TITLE ?? ""
                    self.lbl11.text = item.VALUE ?? ""
                
            }
            if i == 11 {
               
                    self.lblTitle12.text = item.TITLE ?? ""
                    self.lbl12.text = item.VALUE ?? ""
                
            }
            if i == 12 {
             
                    self.lblTitle11.text = item.TITLE ?? ""
                    self.lbl11.text = item.VALUE ?? ""
                
            }
            if i == 13 {
                
                    self.lblTitle14.text = item.TITLE ?? ""
                    self.lbl14.text = item.VALUE ?? ""
                
            }
            if i == 14 {
                
                    self.lblTitle15.text = item.TITLE ?? ""
                    self.lbl15.text = item.VALUE ?? ""
                
            }
            
            i = i + 1
        }
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
