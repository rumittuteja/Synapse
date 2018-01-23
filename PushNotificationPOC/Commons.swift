//
//  Commons.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class Commons: NSObject {
    static var objRootNav:UINavigationController!
    static var objUser:User!
    static var dictSurvey:[String:Any]!
    static var strDeviceToken:String!
//    
//    static func displayAlert(withTitle title:String!, message:String!){
//        let alertController = UIAlertController(title: "Photo Delete", message: "Do you want to delete this photo?", preferredStyle: .alert)
//        let confirmAction = UIAlertAction(title: "OK", style: .default, handler: {(_ action: UIAlertAction) -> Void in
//
//        })
//        alertController.addAction(confirmAction)
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//
//        })
//        alertController.addAction(cancelAction)
//        Commons.objRootNav.present(alertController, animated: true, completion: { _ in })
//    }
//    
    static func displayAlert(withTitle title:String!, message:String){
        let myAlert = UIAlertController(title:title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title:"OK", style:UIAlertActionStyle.default, handler:nil)
        myAlert.addAction(okAction)
        Commons.objRootNav.present(myAlert, animated: true, completion: nil)
    }

}
