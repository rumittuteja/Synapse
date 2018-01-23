//
//  User.swift
//  ARKit
//
//  Created by Rumit Singh Tuteja on 11/8/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class User: NSObject {
    var strName:String!
    var strEmailID:String!
    var strPassword:String!
    var strID:String!
    var sessionToken:String!
    var strContactNo:String?
    var strGender:String?
    var strRole:String?
    var strAddress:String?
    var pushEnabled:Bool?
    init(withParams params:[String:Any]!){
        super.init()
        strName = params["name"] as? String
        strEmailID = params["emailID"] as? String
        strPassword = params["password"] as? String
        strID = params["_id"] as? String
        sessionToken = params["token"] as? String
        strRole = params["role"] as? String
        strGender = params["gender"] as? String
        strAddress = params["address"] as? String
        strContactNo = params["phoneNo"] as? String
        pushEnabled = params["pushEnabled"] as? Bool
    }
}
