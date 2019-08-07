//
//  DelegateResponseData.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/24/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit

struct DelegateData:Decodable {
    let success: Bool?
    var data: [DelegateList]?
}

struct DelegateList:Decodable {
    var USER_ID: String?
    var USER_DELEGATE_ID: String?
    var WEF_DATE: String?
    var DELEGATE_REQ_USER_ID: String?
    var REQ_USER_ID: String?
    var DELEGATE_EXP_USER_ID: String?
    var EXP_USER_ID: String?
    var DELEGATE_NTEXP_USER_ID: String?
    var NTEXP_USER_ID: String?
    var DELEGATE_CASH_USER_ID: String?
    var CASH_USER_ID: String?
}

