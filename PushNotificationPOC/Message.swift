//
//  Message.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/15/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class Message: NSObject {
    var strText:String?
    var strID:String?
    var arrPossibleOutcomes:[String]! = []
    var strSelectedOutcome:String?
    var strType:String?
    var strStudyID:String!
    var strSurveyID:String?
    var isRead:Bool!
    var surveyOwner:String!
   init(withParams params:[String:Any]) {
        super.init()
        strText = params["messageText"] as? String? ?? ""
        strID = params["_id"] as? String? ?? ""
        strType = params["msgType"] as? String ?? ""
        strStudyID = params["study"] as! String!
        isRead = params["isRead"] as! Bool!
        if let strAnswer = params["userAnswer"] as? String{
            strSelectedOutcome = strAnswer
        }
        if let arrOptions = params["answerOptions"] as? [[String:String]] {
            for option in arrOptions {
                let strOption = option["title"]!
                arrPossibleOutcomes.append(strOption)
            }
        }
        if strType == "Survey", let strSurvID = params["surveyId"] as? String{
            strSurveyID = strSurvID
            surveyOwner = params["owner"] as! String
    }
        
    }
}
