//
//  DateUtil.swift
//  Profile
//
//  Created by Milan Katiyar on 22/07/19.
//  Copyright © 2019 learning. All rights reserved.
//

import Foundation
import UIKit
import MBProgressHUD

class DateUtil: NSObject {
     static let UI_DATE_FORMAT = "dd-MM-yyyy";
    static let TA_DATE_FORMAT = "yyyy-MM-dd HH:mm:ss";
    static let AMADEUS_DATE = "yyyy-MM-dd";
    
    static func convertTimeToDateString(timeInMillis : Int64, convertFormat : String) -> String {
        let timeInSec = timeInMillis/1000;
        let date = Date.init(timeIntervalSince1970: TimeInterval(timeInSec));
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.locale = NSLocale.current
        dateFormatter.dateFormat = convertFormat
        let strDate = dateFormatter.string(from : date)
        return strDate
    }
    
    static func convert12HoursMinFormate (date : Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "hh:mm a"
        let dateString = formatter.string(from: date)
        return dateString
    }
    
    static func convertStringToDate(_ dateString : String, reqDateFormat : String)-> Date {
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = reqDateFormat
        let dateFormater1 = DateFormatter()
        dateFormater1.dateFormat = self.AMADEUS_DATE
        
        if let dayDate = dateFormater.date(from: dateString){
            return dayDate
        } else if let dayDate = dateFormater1.date(from: dateString){
            return dayDate
        }
        return Date()
        
    }
    
    static func convertDateToString(date : Date, reqFormat : String) -> String{
        let dateFormater = DateFormatter()
        dateFormater.dateFormat = reqFormat
        let dayString = dateFormater.string(from: date)
        return dayString
    }
    static func convertDate(stringDate: String, stringDateFormat: String, reqDateFormat: String)->String{
        var dateString = stringDateFormat
        if stringDateFormat == "" {
            dateString = TA_DATE_FORMAT
        }
        
        let convertedDate = convertStringToDate(stringDate, reqDateFormat: dateString)
        let convertedStringDate = convertDateToString(date: convertedDate, reqFormat: reqDateFormat)
        return convertedStringDate
    }
}

