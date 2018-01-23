//
//  ViewController.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/11/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import Alamofire

class ViewController: ParentViewController,UITableViewDelegate, UITableViewDataSource {
    @IBOutlet weak var lblImg: UILabel!
    @IBOutlet var viewProfileHeader: UIView!
    @IBOutlet weak var tblbViewController: UITableView!
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(Commons.objUser.pushEnabled)
        // Do any additional setup after loading the view, typically from a nib.
        
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        lblImg.layer.cornerRadius = lblImg.frame.size.height / 2
        lblImg.layer.masksToBounds = true
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return self.viewProfileHeader
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return self.viewProfileHeader.frame.size.height
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "profileCell")
        if indexPath.row == 0{
            cell?.textLabel?.text = "Name"
            cell?.detailTextLabel?.text = Commons.objUser.strName
        }else if indexPath.row == 1{
            cell?.textLabel?.text = "Email ID"
            cell?.detailTextLabel?.text = Commons.objUser.strEmailID
        }else if indexPath.row == 2{
            cell?.textLabel?.text = "Address"
            cell?.detailTextLabel?.text = Commons.objUser.strAddress
        }else if indexPath.row == 3{
            cell?.textLabel?.text = "Contact Number"
            cell?.detailTextLabel?.text = Commons.objUser.strContactNo
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: "pushSwitch") as! PushTableViewCell
            let status: Bool = Commons.objUser.pushEnabled!
            if status{
                cell.switchP?.setOn(true, animated: true)
            }else{
                cell.switchP?.setOn(false, animated: true)
            }
            return cell
        }
        return cell!
    }
    
    
    @IBAction func valueChanged(_ sender: Any) {
        let switchButton = sender as! UISwitch
        let API = switchButton.isOn ? "enableNotification" : "disableNotification"
        let params = ["deviceToken":Commons.strDeviceToken]
        Alamofire.request(
            URL(string: WebAPIs.baseURL + "/" + API + "/" + Commons.objUser.sessionToken + "/" + Commons.objUser.strEmailID)!,
            method: .post,
            parameters: params)
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    return
                }
                if let dictDetails = response.result.value as? [String:Any] {
                    if let status = dictDetails["status"] as? String {
                        if status == "200"{
                            print(dictDetails)
                            if API == "enableNotification"{
                                Commons.objUser.pushEnabled = true
                            }else{
                                Commons.objUser.pushEnabled = false
                            }
                            
                        }else{
                            // alert couldnt log user in
                        }
                    }
                }
        }
        
    }

}
