//
//  ServerCommunication.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/23/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit
import Alamofire

class ServerCommunication: NSObject {
  //  static let baseUrl = "http://tessapp.tess360.com/"
    static let baseUrl = "http://tessapi.travelassist.online/"
    
    
    class func getDataWithGetWithDataResponse(url: String,parameter postParam: Parameters,HeaderParams: [String: String],methodType:HTTPMethod,viewController: UIViewController,success: @escaping(DataResponse<Any>) -> Void,failure: @escaping (NSDictionary) -> Void){
        var param = postParam
        param["LOCATION_ID"] = "66"
        param["ORG_ID"] = "93"
        param["SIGNIN_TYPE"] = "P"
        param["TOKEN"] = "d9b2c69592d7eafa0bdbe6d36e60dc19"
        let urlFinal = baseUrl + url
        print("urlFinal: \(urlFinal) ")
        print("Post Parameter: \(param) ")
        print("Post HeaderParams: \(HeaderParams) ")
        DataUtil.ShowIndictorView(IndicatoreTitle: "")
        
        Alamofire.request(urlFinal, method: .post, parameters: param, encoding: JSONEncoding.default, headers: nil).responseJSON { (response:DataResponse<Any>) in
            if let data = response.data{
                print("******************Json Data Start************************************")
                if let strJson = NSString(data: data, encoding: String.Encoding.utf8.rawValue){
                    print(strJson)
                    
                    
                }
                print("******************Json Data End ************************************")
            }
            switch (response.result){
            case .success(_):
                print("******************success******************")
                guard let json = response.result.value as? NSDictionary else
                {
                    print("Error: \(String(describing: response.result.error))")
                    DataUtil.HideIndictorView()
                    DispatchQueue.main.async {
                        failure(response.result as Any as! NSDictionary )
                    }
                    return
                }
                
                if let httpStatusCode = response.response?.statusCode {
                    
                    if httpStatusCode ==  400 {
                        
                        // let dic = json
                       
                        
                        DataUtil.HideIndictorView()
                        return
                    }
                }
                
                
                //  print(json)
                DispatchQueue.main.async {
                    //  if response.value
                    
                    success(response)
                    
                }
                 DataUtil.HideIndictorView()
            case .failure(_):
                print("******************failure******************")
                DataUtil.alertMessage(response.result.error!.localizedDescription, viewController: viewController)
                print(response.result.error!.localizedDescription)
                
                var str_error_msg = response.result.error!.localizedDescription
                if (str_error_msg .contains("JSON could not be serialized")) {
                  //  str_error_msg = ConstantFiles.technical_issue
                }
                
                DispatchQueue.main.async {
                    if ((response.result.error) as NSError?)?.code == -1009{
                        DataUtil.alertMessage(str_error_msg, viewController: viewController)
                        DispatchQueue.main.async {
                            let dictFail = NSMutableDictionary()
                            dictFail.setValue(-1009, forKey: "errorCode")
                            print("dictFail ==",dictFail) ;
                            
                            failure(dictFail)
                        }
                        return
                    }
                    DataUtil.alertMessage(str_error_msg, viewController: viewController)
                    return
                }
                DataUtil.HideIndictorView()
            }
        }
    }
}
