//
//  PreferenceListVC.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/25/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit
import Alamofire

class PreferenceListVC: BaseProfileVC {
    @IBOutlet weak var tblView: UITableView!
    var listDataArr = [PrefTypeList]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Preference"
        headerViewP.setBasicHeight(height: 0)
        basicViewHeight.constant = 185
        headerViewP.plusBtb.isSelected = true
   
        self.tblView.rowHeight = UITableViewAutomaticDimension;
        self.tblView.estimatedRowHeight = 200;
        self.getData()
    }
    
    func getData() {
        let params:Parameters =  ["ORG_ID": "93", "SIGNIN_TYPE": "P", "TOKEN": "92b2ae6292946dcd6caee78496d98065", "LOCATION_ID": "66"]
        
        let postParamHeaders = [String: String]()
        
        ServerCommunication.getDataWithGetWithDataResponse(url: "getPreferenceDetail", parameter: params, HeaderParams: postParamHeaders, methodType: .post, viewController: self, success: { (successResponseData) in
            if let cryptoData = successResponseData.data {
                do {
                    let decoder = JSONDecoder()
                    
                    let serviceResponse = try decoder.decode(PreferenceData.self, from: cryptoData)
                    if serviceResponse.success == true {
                        if let arr = serviceResponse.data?.types {
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
extension PreferenceListVC: UITableViewDataSource, UITableViewDelegate {
  
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 48
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.listDataArr.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PreferenceTypeCell") as! PreferenceTypeCell
        cell.setInfoData(self.listDataArr[indexPath.row])
        return cell
    }
}

class PreferenceTypeCell: UITableViewCell {
    @IBOutlet weak var viewpref: UIView!
    @IBOutlet weak var typeTxt: UILabel!
    var InfoList:PrefTypeList?
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    func setInfoData(_ cellInfo: PrefTypeList) {
        self.viewpref.layer.borderWidth = 1
        self.viewpref.layer.borderColor = UIColor.lightGray.cgColor
        self.InfoList = cellInfo
        if let Info =  self.InfoList {
            if let text = Info.LOOKUP_TYPE {
                self.typeTxt.text = text
            }
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}



