    //
//  ParentViewController.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/13/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class ParentViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        Commons.objRootNav = self.navigationController
        checkForSession()
        // Do any additional setup after loading the view.
    }
//    right now even if you try to think too hard and take it all in at once, its not gonna be lasting over a decade, its a marathon not a sprint. Decide and start working, theres time, work on it, see what happens, you are in the game. This is what you can really take control of. Keep working, the results will start to show slowly but surely.
    func userIsInSession() -> Bool {
        if let _ = Commons.objUser, let _ = Commons.objUser.sessionToken {
            return true
        }else{
            return false
        }
    }
    
    func checkForSession(){
        if Commons.objUser == nil, let dictUser = UserDefaults.standard.value(forKey: "session") as? [String:Any] {
            let user = User(withParams:dictUser)
            Commons.objUser = user
        }
    }
    
    func logUserIntoTheApp(){
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "messagesNav")
        UIApplication.shared.delegate?.window??.rootViewController = vc    
    }
    
    func logUserOut(){
//        if let _ = Commons.objUser, let _ = UserDefaults.standard.value(forKey: "session") {
            Commons.objUser = nil
            UserDefaults.standard.set(nil, forKey: "session")
            let storyboard = UIStoryboard(name:"Main",bundle:nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "loginNav")
            UIApplication.shared.delegate?.window??.rootViewController = vc
//        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
