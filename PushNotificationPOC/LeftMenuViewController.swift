//
//  LeftMenuViewController.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class LeftMenuViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    let arrItems = ["MY COACH (MESSENGER)","MY PROFILE","LOGOUT"]
    @IBOutlet weak var txtViewLeftMenu: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblIcon.layer.cornerRadius = lblIcon.frame.size.width / 2
        lblIcon.layer.masksToBounds = true
    }
    
    @IBOutlet weak var lblIcon: UILabel!
    @IBOutlet var viewHeader: UIView!
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return viewHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return viewHeader.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        cell?.textLabel?.text = arrItems[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        var vcID:String?
        if indexPath.row == 0 {
            vcID = "messages"
        }else if indexPath.row == 1 {
            vcID = "profile"
        }else if indexPath.row == 2 {
            dismiss(animated: true, completion: nil)
            logUserOut()
            return
        }
        let vc = storyboard.instantiateViewController(withIdentifier: vcID!)
        Commons.objRootNav.viewControllers = [vc]
        dismiss(animated: true, completion: nil)
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
