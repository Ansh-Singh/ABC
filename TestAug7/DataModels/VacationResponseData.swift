//
//  VacationResponseData.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/25/19.
//  Copyright © 2019 learning. All rights reserved.
//

import UIKit

struct VacationData:Decodable {
    let success: Bool?
    var data: [VacationList]?
}
struct VacationList:Decodable {
    var USER_ID: String?
    var USER_VAC_ID: String?
    var EMP_USER_ID: String?
    var EMP_NAME: String?
    var START_DATE: String?
    var END_DATE: String?
    var PURPOSE_COMMENT: String?
}

