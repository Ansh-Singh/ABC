//
//  ViewController.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/22/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: BaseProfileVC {
@IBOutlet weak var profileCollectioView:UICollectionView!
    var LookUpsTypeArr = [ProfileLookupType]()

  
    override func viewDidLoad() {
        super.viewDidLoad()
         headerViewP.setBasicHeight(height: 0)
        basicViewHeight.constant = 185
        headerViewP.plusBtb.isSelected = true
        self.getData()
        // Do any additional setup after loading the view.
    }
    func getData(){
        
       // "LOOKUP_FLAG":"X", "SYSTEM_ID":"T", "SIGNIN_TYPE":"P"
        let params:Parameters =  ["LOOKUP_FLAG": "X", "SYSTEM_ID": "T", "SIGNIN_TYPE": "P"]
        
        let postParamHeaders = [String: String]()
        
        ServerCommunication.getDataWithGetWithDataResponse(url: "hrProfileLookups", parameter: params, HeaderParams: postParamHeaders, methodType: .post, viewController: self, success: { (successResponseData) in
            if let cryptoData = successResponseData.data {
                do {
                    let decoder = JSONDecoder()
                    
                    let serviceResponse = try decoder.decode(ProfileDashData.self, from: cryptoData)
                    if serviceResponse.success == true {
                        if var types = serviceResponse.data?.LOOKUPS_TYPES {
                          // types.remove(at: 0)
                            self.LookUpsTypeArr = types
                            
                        }
                        if let userInfo = serviceResponse.data?.USER_INFO {
                            basicInfoG = userInfo
                            self.headerViewP.basicInfo = userInfo
                            self.headerViewP.setValues(userData: userInfo)
                            
                        }
                        
                        
                        self.profileCollectioView.reloadData()
                        
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
    class ProfileCollecCell: UICollectionViewCell{
        @IBOutlet weak var ttlLabel:UILabel!
        @IBOutlet weak var iconeImage:UIImageView!
        
    }
extension ViewController:UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{
  
    
        // MARK: collectionView Delegate
        
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        let story = UIStoryboard(name: "Main", bundle: nil)
        
        let obj = story.instantiateViewController(withIdentifier: "ProfileListVC") as! ProfileListVC
        
        obj.obj_lookUpType = self.LookUpsTypeArr[indexPath.row]
        self.navigationController?.pushViewController(obj, animated: true)
        return
        
    }
        func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
            
           let cellWidth = (DataUtil.screenWidth-60)/4
            return CGSize(width: cellWidth, height: cellWidth)
            
        }
        
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
         
            return self.LookUpsTypeArr.count
            
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
            
            let identifier = "ProfileCollecCell"
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! ProfileCollecCell
            
            let obj = self.LookUpsTypeArr[indexPath.row]
            cell.ttlLabel.text = obj.LOOKUP_TYPE
            
            return cell
            
        }
        
        
        
    }


protocol updateProfileListData: class {
    func updateListData(attributArray: [AttributeForm],listId: String, isUpdate: Bool)
}

