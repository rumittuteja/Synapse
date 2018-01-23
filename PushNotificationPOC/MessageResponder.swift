//
//  MessageResponder.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/16/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class MessageResponder: BaseDataFetcher {
    func postReply(toMessage objMsg:Message, completionHandler:@escaping (Bool?, Error?)->Void){
        fetchData(withURLString: WebAPIs.baseURL + "/sendMsgResponse/" + Commons.objUser.sessionToken + "/" + Commons.objUser.strEmailID, methodType: .post, params: ["msgId":objMsg.strID!, "response":objMsg.strSelectedOutcome!]) { (dictResponse, error) in
            if error == nil {
                completionHandler(true,error)
            }else{
                Commons.displayAlert(withTitle: "SERVER ERROR", message: "We couldn't post your answer at this time. Please try to post your response again")
                completionHandler(false,error)
            }
        }
    }
}
