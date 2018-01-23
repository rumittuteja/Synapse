//
//  MessagesFetcher.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/13/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class MessagesFetcher: BaseDataFetcher {
    func fetchMessages(withParams params:[String:Any]?, completionhandler handler:@escaping ([Message]?,Error?) -> Void){
        fetchData(withURLString: WebAPIs.baseURL + "/getMessagesPerUser/" + Commons.objUser.sessionToken + "/" + Commons.objUser.strEmailID, methodType: .get, params: params) { (dictResponse, error) in
            if error == nil {
                if let dictMessages = dictResponse?["messages"] as? [[String:Any]] {
                    var arrMessages = [Message]()
                    for dictMessage in dictMessages {
                        let message = Message(withParams:dictMessage)
                        arrMessages.append(message)
                    }
                    handler(arrMessages,error)
                }else{
                    handler([],error)
                }
            }else{
                Commons.displayAlert(withTitle: "SERVER ERROR", message: "We couldn't fetch messages. Please pull down to refresh the feed again.")
            }
        }
    }
}
