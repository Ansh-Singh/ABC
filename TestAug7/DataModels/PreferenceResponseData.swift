//
//  PreferenceResponseData.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/25/19.
//  Copyright © 2019 learning. All rights reserved.
//
import UIKit
class PreferenceData: Decodable {
    
    var success : Bool?
    var data : GetPrefData?
}
class GetPrefData : Decodable {
    var types :[PrefTypeList]?
}
class PrefTypeList : Decodable {
    var LOOKUP_TYPE_ID: String?
    var LOOKUP_TYPE: String?
    var SELECTION_TYPE: String?
    var DETAIL :[PrefDetail]?
}
class PrefDetail : Decodable {
    var LOOKUP_TYPE_ID: String?
    var LOOKUP_ID: String?
    var LOOKUP_CODE: String?
    var LOOKUP_MEANING: String?
    var SELECTED: String?
}

struct PrefDetailClone  {
    var LOOKUP_TYPE_ID: String?
    var LOOKUP_ID: String?
    var LOOKUP_CODE: String?
    var LOOKUP_MEANING: String?
    var SELECTED: String?
    
}

