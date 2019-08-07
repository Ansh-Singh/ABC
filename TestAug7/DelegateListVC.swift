//
//  DelegateListVC.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/24/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit
import Alamofire

class DelegateListVC: BaseProfileVC {
    @IBOutlet weak var tblView: UITableView!
    var listDataArr = [DelegateList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Delegate"
        headerViewP.setBasicHeight(height: 0)
        basicViewHeight.constant = 185
        headerViewP.plusBtb.isSelected = true
        tblView.register(UINib(nibName: "AddressCell", bundle: nil), forCellReuseIdentifier: "AddressCell")
        self.tblView.rowHeight = UITableViewAutomaticDimension;
        self.tblView.estimatedRowHeight = 200;
        self.getData()
    }
    
    func getData() {
        let params:Parameters =  ["ORG_ID": "93", "SIGNIN_TYPE": "P", "TOKEN": "92b2ae6292946dcd6caee78496d98065", "LOCATION_ID": "66"]
        
        let postParamHeaders = [String: String]()
        
        ServerCommunication.getDataWithGetWithDataResponse(url: "getDeligateUserHistory", parameter: params, HeaderParams: postParamHeaders, methodType: .post, viewController: self, success: { (successResponseData) in
            if let cryptoData = successResponseData.data {
                do {
                    let decoder = JSONDecoder()
                    
                    let serviceResponse = try decoder.decode(DelegateData.self, from: cryptoData)
                    if serviceResponse.success == true {
                        if let arr = serviceResponse.data {
                            self.listDataArr = arr
                        }
                        
                        print("self.licenseListDataArr ==",self.listDataArr)
                        if self.listDataArr.count < 1 {
                            self.noDataFoundView.isHidden = false
                        }
                        else {
                            self.noDataFoundView.isHidden = true
                        }
                        self.tblView.reloadData()
                        
                    }
                    else {
                        
                        
                        if let dictFailure = successResponseData.result.value as? [String: AnyObject]{
                            
                            if let msg = dictFailure["message"] as? String
                            {
                                
                                DataUtil.alertMessage(msg , viewController: self)
                            }
                        }
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
extension DelegateListVC: UITableViewDataSource, UITableViewDelegate {
    @objc func openOptionsforCell(btn: UIButton) {
        let obj = self.listDataArr[btn.tag]
        let alert = UIAlertController(title: nil, message: nil, preferredStyle: UIAlertController.Style.actionSheet)
        
        alert.addAction(UIAlertAction(title:"Edit", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            
        }))
        alert.addAction(UIAlertAction(title:"Delete", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
            if let recordId = obj.DELEGATE_REQ_USER_ID {
                
                self.removePassport(type: "DELEGATE", recordId: recordId, success: { (str) in
                    
                    self.listDataArr.remove(at: btn.tag)
                    self.tblView.reloadData()
                    if self.listDataArr.count < 1 {
                        self.noDataFoundView.isHidden = false
                    }
                    else {
                        self.noDataFoundView.isHidden = true
                    }
                    
                })
                
                //self.removePassport(type: "PASSPORT", recordId: recordId)
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
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 230
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "DelegateCell") as! DelegateCell
        cell.setInfoData(self.listDataArr[indexPath.row])
        cell.btnthreeDots.tag = indexPath.row
        cell.btnthreeDots.addTarget(self, action: #selector(openOptionsforCell(btn:)), for: .touchUpInside)
        return cell
    }
    
    
}

class DelegateCell: UITableViewCell {
    @IBOutlet weak var btnthreeDots: UIButton!
    @IBOutlet weak var lblWEFDate: UILabel!
    @IBOutlet weak var lblReqUser: UILabel!
    @IBOutlet weak var lblExpUser: UILabel!
    @IBOutlet weak var lblNonTravelExpUser: UILabel!
    @IBOutlet weak var lblCashUser: UILabel!
    
    var InfoList:DelegateList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setInfoData(_ cellInfo: DelegateList) {
        self.InfoList = cellInfo
        if let Info =  self.InfoList {
            
            if let name = Info.DELEGATE_REQ_USER_ID {
                self.lblReqUser.text = name
            }
            if let name = Info.DELEGATE_EXP_USER_ID {
                self.lblExpUser.text = name
            }
            if let name = Info.DELEGATE_NTEXP_USER_ID {
                self.lblNonTravelExpUser.text = name
            }
            if let name = Info.DELEGATE_CASH_USER_ID {
                self.lblCashUser.text = name
            }
            
            if let date = Info.WEF_DATE {
                self.lblWEFDate.text = DateUtil.convertDate(stringDate: date, stringDateFormat: DateUtil.TA_DATE_FORMAT, reqDateFormat: DateUtil.UI_DATE_FORMAT)
            }
      
            
            
        }
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}






