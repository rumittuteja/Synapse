//
//  SurveyDataFetcher.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 12/13/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class SurveyDataFetcher: BaseDataFetcher {

    func fetchSurvey(withParams params:[String:Any]!, completionhandler handler:@escaping ([String:Any]?,Error?) -> Void){
        fetchData(withURLString: WebAPIs.baseURL + "/getSurveysForUser/"+Commons.objUser.sessionToken!+"/" + Commons.objUser.strEmailID!, methodType: .post, params: params) { (dictResponse, error) in
            if error == nil, let dictSurvey = dictResponse {
                handler(dictSurvey, nil)
            }else{
                Commons.displayAlert(withTitle: "SERVER ERROR", message: "We couldnt fetch the durvey data at this time. Please re-initiate the survey.")
                handler(nil, error)
            }
        }
    }
}
