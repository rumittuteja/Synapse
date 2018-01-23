//
//  SurveyResponseHandler.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 12/13/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class SurveyResponseHandler: BaseDataFetcher {
    func postSurveyResponse(withParams params:[String:Any]!, completionhandler handler:@escaping ([String:Any]?,Error?) -> Void){
        fetchData(withURLString: WebAPIs.baseURL + "/createSurveyResponse/" + Commons.objUser.sessionToken!+"/" + Commons.objUser.strEmailID!, methodType: .post, params: params) { (dictResponse, error) in
            if error == nil, let dictSurvey = dictResponse {
                handler(dictSurvey, nil)
            }else{
                Commons.displayAlert(withTitle: "SERVER ERROR", message: "We couldn't post the survey results at this time. Please try taking the survey again.")
                handler(nil, error)
            }
        }
    }
}
        
        
//        Alamofire.request(
//            URL(string: "http://18.220.163.207:8080/createUserResponse/" + token + "/" + email)!,
//            method: .post,
//            parameters: params)
//            .validate(contentType: ["application/json"])
//            .responseJSON { [weak self] (response) -> Void in
//                guard response.result.isSuccess else {
//                    print("Error while fetching remote rooms: \(response.result.error)")
//                    return
//                }
//                guard let responseJSON = response.result.value as? [String: Any] else {
//                    print("Invalid tag information received from the service")
//                    
//                    return
//                }
//                print(responseJSON)
//                var dictionary = responseJSON["userDetails"] as! [String:Any]
//                dictionary["token"] = responseJSON["token"] as! String
//                let user = User(withParams:dictionary)
//                UserDefaults.standard.set(dictionary, forKey: "session")
//                Commons.objUser = user
//                print("Hello")
//                self?.logUserIntoTheApp()
//        }
//        
//        
//    }
//}
