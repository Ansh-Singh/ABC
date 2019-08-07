//
//  ProfileDashBoardResponse.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/29/19.
//  Copyright © 2019 learning. All rights reserved.
//

struct ProfileDashData:Decodable {
    let success: Bool?
    var data : DataDash?
}
struct DataDash:Decodable {
    var LOOKUPS_TYPES: [ProfileLookupType]?
    var USER_INFO: UserBasicInfo?
}

struct ProfileLookupType:Decodable  {
    var LOOKUP_TYPE_ID: String?
    var LOOKUP_TYPE: String?
    var BAND_LINK: String?
    var LIMIT_TYPE_ID: String?
    var SELECTION_TYPE: String?
    var TRAVEL_MODE_CODE: String?
    var LOOKUP_FLAG: String?
    var SYSTEM_ID: String?
    
}
public class UserBasicInfo:Decodable  {
    var ORG_ID: String?
    var LOCATION_ID: String?
    var USER_ID: String?
    var USER_TYPE: String?
    var FNAME: String?
    var MNAME: String?
    var LNAME: String?
    var USERNAME: String?
    var PASSWORD: String?
    var EMAIL: String?
    var DOB: String?
    var MOBILE_NO: String?
    var PROFILE_IMAGE: String?
    var PASSCODE: String?
    var USER_VERIFIED: String?
    var INSERTED_DATE: String?
    var UPDATED_DATE: String?
    var UPDATED_BY: String?
    var INSERTED_BY: String?
    var IS_DEFAULT: String?
    var DEL: String?
    var TOKEN: String?
    var CONSULTANT_AUTHORIZATION: String?
    var DISPLAY_NAME: String?
    var FCM_TOKEN: String?
    var SEX_ID: String?
    var RELIGION_ID: String?
    var BLOOD_GROUP_ID: String?
    var MARITAL_STATUS: String?
    var EMPLOYEE_NUMBER: String?
    var TEAM_NAME: String?
    var DATE_OF_JOIN: String?
    var ADDRESS1: String?
    var ADDRESS2: String?
    var ADDRESS3: String?
    
}


