//
//  AttributesResponseData.swift
//  Profile
//
//  Created by HIPL-GLOBYLOG on 7/30/19.
//  Copyright © 2019 learning. All rights reserved.
//

class AttributProfileData:Decodable {
    let success: Bool?
    var data : DataAttribute?
}
class DataAttribute:Decodable {
    var ATTRIBUTES:[AttributeForm]?
    var DETAIL:[DetailListProfile]?
}
class DetailListProfile:Decodable  {
    var LIST_ID: String?
    var LIST: [ListData]?
    
    
}
class ListData:Decodable  {
    var VALUE: String?
    var TITLE: String?
    var HR_PROFILE_ATTRIBUTE_ID: String?
    var PROFILE_ATTRIBUTE_ID: String?
    var LOOKUP_ID: String?
    var TYPE: String?
}

class AttributeForm:Decodable  {
    var LOOKUP_TYPE_ID: String?
    var PROFILE_ATTRIBUTE_ID: String?
    var HR_PROFILE_ATTRIBUTE_ID: String?
    var PROFILE_ATTRIBUTE_DESCRIPTION: String?
    var PROFILE_ATTRIBUTE_TYPE: String?
    var PROFILE_ATTRIBUTE_SIZE: String?
    var PROFILE_ATTRIBUTE_DEFAULT_VALUE:String?
    var PROFILE_ATTRIBUTE_REQUIRED: String?
    var PROFILE_ATTRIBUTE_SEQUENCE: String?
    var PROFILE_ATT_LOOKUP_SOURCE: String?
    var PROFILE_ATT_LOOKUP_FILTER_ID: String?
    var PROFILE_ATTRIBUTE_DEFAULT_LOOKUP_ID: String?
    var PROFILE_ATTRIBUTE_GEO_LEVEL: String?
    var PROFILE_ATTTRIBUTE_HELP_ID: String?
    var PROFILE_ATTRIBUTE_HIDE_VALUE: String?
    var LOOKUP_ID: String?
    var ADDITIONAL_ATTRIBUTES: [AddiProfileData]?  // array for drop down
    
}
class AttributeFormClone:Decodable  {
    var LOOKUP_TYPE_ID: String?
    var PROFILE_ATTRIBUTE_ID: String?
    var HR_PROFILE_ATTRIBUTE_ID: String?
    var PROFILE_ATTRIBUTE_DESCRIPTION: String?
    var PROFILE_ATTRIBUTE_TYPE: String?
    var PROFILE_ATTRIBUTE_SIZE: String?
    var PROFILE_ATTRIBUTE_DEFAULT_VALUE:String?
    var PROFILE_ATTRIBUTE_REQUIRED: String?
    var PROFILE_ATTRIBUTE_SEQUENCE: String?
    var PROFILE_ATT_LOOKUP_SOURCE: String?
    var PROFILE_ATT_LOOKUP_FILTER_ID: String?
    var PROFILE_ATTRIBUTE_DEFAULT_LOOKUP_ID: String?
    var PROFILE_ATTRIBUTE_GEO_LEVEL: String?
    var PROFILE_ATTTRIBUTE_HELP_ID: String?
    var PROFILE_ATTRIBUTE_HIDE_VALUE: String?
    var ADDITIONAL_ATTRIBUTES: [AddiProfileData]?  // array for drop down
    
}
class AddiProfileData:Decodable  {
    var LOOKUP_TYPE_ID: String?
    var LOOKUP_ID: String?
    var LOOKUP_CODE: String?
    var LOOKUP_MEANING: String?
}




