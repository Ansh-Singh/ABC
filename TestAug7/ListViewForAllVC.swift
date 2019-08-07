//
//  ListViewForAllVC.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/25/19.
//  Copyright © 2019 learning. All rights reserved.
import UIKit
import Alamofire

class ListViewForAllVC: UIViewController {
@IBOutlet weak var tblView: UITableView!
    weak var delegateUpdate:updateProfileListData!
    var dataSetId: String?
    @IBOutlet weak var footrView: UIView!
    var obj_lookUpType: ProfileLookupType?
    var attributArray: [AttributeForm]!
    var attributArrayClone: [AttributeFormClone]!
    @IBOutlet weak var lblTitle: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
      //  attributArrayClone = attributArray.copy()
        
        if dataSetId == nil {
            attributArray = [AttributeForm]()
        for item in self.attributArrayClone {
            let objClone = AttributeForm()
            objClone.LOOKUP_TYPE_ID = item.LOOKUP_TYPE_ID
            objClone.PROFILE_ATTRIBUTE_ID = item.PROFILE_ATTRIBUTE_ID
            
            objClone.HR_PROFILE_ATTRIBUTE_ID = item.HR_PROFILE_ATTRIBUTE_ID
            objClone.PROFILE_ATTRIBUTE_DESCRIPTION = item.PROFILE_ATTRIBUTE_DESCRIPTION
            objClone.PROFILE_ATTRIBUTE_TYPE = item.PROFILE_ATTRIBUTE_TYPE
            objClone.PROFILE_ATTRIBUTE_SIZE = item.PROFILE_ATTRIBUTE_TYPE
            objClone.PROFILE_ATTRIBUTE_DEFAULT_VALUE = ""
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
            attributArray.append(objClone)
        }
     }
        else {
            for item in self.attributArray {
            }
        }
        
        
        if let obj = obj_lookUpType {
            self.lblTitle.text = obj.LOOKUP_TYPE ?? ""
        }
       self.tblView.tableFooterView = footrView
 tblView.register(UINib(nibName: "TextFieldCell", bundle: nil), forCellReuseIdentifier: "TextFieldCell")
        
 tblView.register(UINib(nibName: "DateTextFieldCell", bundle: nil), forCellReuseIdentifier: "DateTextFieldCell")
        
 tblView.register(UINib(nibName: "DatePeriodTextFCell", bundle: nil), forCellReuseIdentifier: "DatePeriodTextFCell")
  tblView.register(UINib(nibName: "DropDownCell", bundle: nil), forCellReuseIdentifier: "DropDownCell")
        
     tblView.register(UINib(nibName: "AddressGeoCell", bundle: nil), forCellReuseIdentifier: "AddressGeoCell")
        
        super.viewDidLoad()

        if attributArray.count < 1 {
    tblView.isHidden = true
        }
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
    @IBAction func backClicked() {
       self.dismiss(animated: true, completion: nil)
    
    }
    @IBAction func SaveClicked() {
        self.view.endEditing(true)
        if isValidate() == true {
            if let obj = obj_lookUpType {
                var params:Parameters = [String:String]()
                var array = [Parameters]()
                var lookId  = ""
                for item in self.attributArray {
                    if lookId.isEmpty {
                    lookId = item.LOOKUP_TYPE_ID ?? ""
                    }
                    params["PROFILE_ATTRIBUTE_ID"] = item.PROFILE_ATTRIBUTE_ID ?? ""
                    params["PROFILE_ATTRIBUTE_TYPE"] = item.PROFILE_ATTRIBUTE_TYPE ?? ""
                    
                    if item.LOOKUP_ID != nil && item.PROFILE_ATTRIBUTE_TYPE! == "L" {
                        
                         params["PROFILE_ATTRIBUTE_DEFAULT_VALUE"] = item.LOOKUP_ID!
                    }
                    else {
                    params["PROFILE_ATTRIBUTE_DEFAULT_VALUE"] = item.PROFILE_ATTRIBUTE_DEFAULT_VALUE ?? ""
                    }
                    params["PROFILE_ATTRIBUTE_SEQUENCE"] = item.PROFILE_ATTRIBUTE_SEQUENCE ?? ""
                    params["PROFILE_ATT_LOOKUP_FILTER_ID"] = item.PROFILE_ATT_LOOKUP_FILTER_ID ?? ""
                    params["PROFILE_ATTRIBUTE_GEO_LEVEL"] = item.PROFILE_ATTRIBUTE_GEO_LEVEL ?? ""
                     params["HR_PROFILE_ATTRIBUTE_ID"] = item.HR_PROFILE_ATTRIBUTE_ID ?? ""
                    array.append(params)
                    
                }
                 var params2:Parameters = [String:Any]()
                params2["ATTRIBUTES"] = array
                params2["LOOKUP_TYPE_ID"] = lookId
               
                params2["DATASET_ID"] = dataSetId ?? ""
                
                
                let postParamHeaders = [String: String]()
                
                ServerCommunication.getDataWithGetWithDataResponse(url: "profileDataAddUpdate", parameter: params2, HeaderParams: postParamHeaders, methodType: .post, viewController: self, success: { (successResponseData) in
                if successResponseData.data != nil {
                        if let json = successResponseData.result.value as? NSDictionary {
            if let succ = json["success"] as? Bool {
                
                if succ == true {
                
                                var setId = ""
                                if let data = json["data"] as? NSDictionary {
                                    setId = data["DATASET_ID"] as! String
                                }
                                
                                    
                                    
                if succ == true {
                    if let set_id = self.dataSetId {
                        setId = set_id
             self.delegateUpdate.updateListData(attributArray: self.attributArray ,listId: setId,isUpdate: true)
                    }
                    else {
             self.delegateUpdate.updateListData(attributArray: self.attributArray ,listId: setId,isUpdate: false)
                        
                    }
                self.dismiss(animated: true, completion: nil)
                
                                
    
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
    func getData(){
       
        
        if let obj = obj_lookUpType {
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
                            // types.remove(at: 0)
                        self.attributArray = types
                            self.tblView.reloadData()
                            
                        }
                        /*
                        if let userInfo = serviceResponse.data?.USER_INFO {
                            basicInfoG = userInfo
                            self.headerViewP.basicInfo = userInfo
                            self.headerViewP.setValues(userData: userInfo)
                            
                        }
                        */
                        
                        
                        
                        
                    }
                    else {
                        
                        
                        if let dictFailure = successResponseData.result.value as? [String: AnyObject]{
                            
                            if let msg = dictFailure["message"] as? String
                            {
                                
                                DataUtil.alertMessage(msg , viewController: self)
                            }
                        }
                    }
                    // self.crytoResponse = serviceResponse
                    // cryptoResponseG = serviceResponse
                    
                    
                    
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
}
extension ListViewForAllVC: UITableViewDataSource, UITableViewDelegate,BaseTextViewDelegate,BaseDateViewDelegate,BasePeriodDateDelegate,BaseDropDownDelegate, BaseAddressDelegate{
    func UpdateAddressText(view: BaseAddressView, index: Int, text: String) {
            print("selected dropdown == \(view.tag)value and value",text)
        
        let obj = attributArray[view.tag]
        obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE = text
        
    }
    
    func UpdateDropDownText(view: BaseDropDownView,index:Int, text: String) {
         print("selected dropdown == \(view.tag)value and value",text)
        let obj = attributArray[view.tag]
        if let obj_additional = obj.ADDITIONAL_ATTRIBUTES?[index] {
            obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE = text
            obj.LOOKUP_ID =  obj_additional.LOOKUP_ID
             print("selected LOOKUP_ID == \(obj_additional.LOOKUP_ID)")
        }
        //print("selected dropdown ==",text)
    }
    
    func UpdatePeriodDateText(view: PeriodDatesView, text: String, IndexDate: Int) {
        print("selected Date ==",text)
    }
    
    func UpdateDateBaseText(view: BaseTextViewWithDate, text: String) {
        
        var obj = attributArray[view.tag]
        obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE = text
        print("selected Date ==",text)
    }

    
    func UpdateBaseText(view: BaseTextView, text: String) {
        var obj = attributArray[view.tag]
        obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE = text
        print("text for tag == \(view.tag)alue and value",text)
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return attributArray.count
    }
    
    //    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
    //        return 140
    //    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let obj = attributArray[indexPath.row]
        
        if obj.PROFILE_ATTRIBUTE_TYPE! == "A" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            cell.BaseTFView.Delegate = self
            cell.BaseTFView.tag = indexPath.row
            cell.BaseTFView.title_lbl.text = obj.PROFILE_ATTRIBUTE_DESCRIPTION!
            if let txt = obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE {
            cell.BaseTFView.generic_textField.text = txt
            }
            else {
                cell.BaseTFView.generic_textField.text = ""
            }
            return cell
             }
        if obj.PROFILE_ATTRIBUTE_TYPE! == "N" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
            cell.BaseTFView.Delegate = self
            cell.BaseTFView.tag = indexPath.row
            cell.BaseTFView.title_lbl.text = obj.PROFILE_ATTRIBUTE_DESCRIPTION!
            
            if let txt = obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE {
                cell.BaseTFView.generic_textField.text = txt
            }
            else {
                cell.BaseTFView.generic_textField.text = ""
            }
            cell.BaseTFView.generic_textField.keyboardType = .phonePad
            return cell
        }
            
        else if obj.PROFILE_ATTRIBUTE_TYPE! == "G" {
            var geoLabel  = "0"
            let cell = tableView.dequeueReusableCell(withIdentifier: "AddressGeoCell") as! AddressGeoCell
            cell.addressView.Delegate = self
            cell.addressView.tag = indexPath.row
            cell.addressView.title_lbl.text = obj.PROFILE_ATTRIBUTE_DESCRIPTION!
            cell.addressView.dropDownLbl.text = obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE ?? ""
            if let geoValue = obj.PROFILE_ATTRIBUTE_GEO_LEVEL {
                geoLabel = geoValue
            }
            if let geoValue = obj.PROFILE_ATTRIBUTE_GEO_LEVEL {
                geoLabel = geoValue
            }
           cell.addressView.setAddressGeoLavel(PROFILE_ATTRIBUTE_GEO_LEVEL: geoLabel, viewController: self)
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            return cell
        }
        else if obj.PROFILE_ATTRIBUTE_TYPE! == "L"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as! DropDownCell
            cell.dropDownBView.Delegate = self
            cell.dropDownBView.tag = indexPath.row
            
            cell.dropDownBView.title_lbl.text = obj.PROFILE_ATTRIBUTE_DESCRIPTION!
            if let addiList = obj.ADDITIONAL_ATTRIBUTES {
                var nameArray = [String]()
                for item in addiList {
                    nameArray.append(item.LOOKUP_MEANING!)
                }
                // let nameArray = ["Milan", "Ajendra", "Farmood","Satish","Ranjeet","MFD"]
                cell.dropDownBView.setArrayForDropDown(listArray: nameArray)
                
                cell.dropDownBView.dropDownLbl.text = obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE ?? ""
                
            }
            
            
            
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            return cell
        }
        else if obj.PROFILE_ATTRIBUTE_TYPE! == "D"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTextFieldCell") as! DateTextFieldCell
            cell.View_date.Delegate = self
            cell.View_date.tag = indexPath.row
            cell.View_date.title_lbl.text = obj.PROFILE_ATTRIBUTE_DESCRIPTION!
            if let txt = obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE {
                cell.View_date.generic_textField.text = txt
            }
            else {
                cell.View_date.generic_textField.text = ""
            }
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            return cell
        }
        else if obj.PROFILE_ATTRIBUTE_TYPE! == "L"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as! DropDownCell
            cell.dropDownBView.Delegate = self
            cell.dropDownBView.tag = indexPath.row
            
            cell.dropDownBView.title_lbl.text = obj.PROFILE_ATTRIBUTE_DESCRIPTION!
            if let addiList = obj.ADDITIONAL_ATTRIBUTES {
                var nameArray = [String]()
                for item in addiList {
                    nameArray.append(item.LOOKUP_MEANING!)
                }
               // let nameArray = ["Milan", "Ajendra", "Farmood","Satish","Ranjeet","MFD"]
        cell.dropDownBView.setArrayForDropDown(listArray: nameArray)
                
        cell.dropDownBView.dropDownLbl.text = obj.PROFILE_ATTRIBUTE_DEFAULT_VALUE ?? ""
                
            }
            
        
            
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            return cell
        }
            
      
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            
            
            /*
            let cell = tableView.dequeueReusableCell(withIdentifier: "DropDownCell") as! DropDownCell
            cell.dropDownBView.Delegate = self
            cell.dropDownBView.tag = indexPath.row
            
            cell.dropDownBView.title_lbl.text = obj.PROFILE_ATTRIBUTE_DESCRIPTION!
            let nameArray = ["Milan", "Ajendra", "Farmood","Satish","Ranjeet","MFD"]
            cell.dropDownBView.setArrayForDropDown(listArray: nameArray)
      
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            return cell
            */
       
        /*
        if indexPath.row == 0 || indexPath.row == 4 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DateTextFieldCell") as! DateTextFieldCell
            cell.View_date.Delegate = self
            cell.View_date.tag = indexPath.row
            cell.View_date.title_lbl.text = "Name"
         
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            return cell
        }
        */
        /*
        if indexPath.row == 2 || indexPath.row == 3 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "DatePeriodTextFCell") as! DatePeriodTextFCell
            cell.periodDate_view.Delegate = self
            cell.periodDate_view.tag = indexPath.row
             cell.periodDate_view.startDate_lbl.text = "Name1"
            cell.periodDate_view.endDate_lbl.text = "Name2"
         
            //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
            return cell
        }
        */
        let cell = tableView.dequeueReusableCell(withIdentifier: "TextFieldCell") as! TextFieldCell
        cell.BaseTFView.Delegate = self
        cell.BaseTFView.tag = indexPath.row
        cell.BaseTFView.title_lbl.text = "Name"
      
        //cell.setAddressInfoData(self.addressListDataArr[indexPath.row])
        return cell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }  
}
