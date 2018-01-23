//
//  BaseDataFetcher.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/13/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import Alamofire
class BaseDataFetcher: NSObject {
    // validity checker
    // json extractor
    
    func fetchData(withURLString urlString:String!, methodType:HTTPMethod!, params:[String:Any]!, completionHandler handler:@escaping ([String:Any]?, Error?)->Void){
        Alamofire.request(
            URL(string: urlString)!,
            method: methodType,
            parameters: params)
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                   handler(nil,response.result.error)
                    return
                }
                if let dictDetails = response.result.value as? [String:Any] {
                    if let status = dictDetails["status"] as? String {
                        if status == "200"{
                            print(dictDetails)
                            handler(dictDetails,nil)
                        }else{
                            // alert couldnt log user in
                        }
                    }
                }
        }
    }
    
    

    
}
