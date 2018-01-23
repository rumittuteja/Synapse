//
//  QuestionDetailViewController.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/16/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit

class QuestionDetailViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var objMessage:Message!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = objMessage?.arrPossibleOutcomes?.count{
            return count + 2
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == 0{
            let cell = tableView.dequeueReusableCell(withIdentifier: "questionCell")
            cell?.textLabel?.text = objMessage.strText
            return cell!
        }else if indexPath.row <= objMessage.arrPossibleOutcomes.count{
            let cell = tableView.dequeueReusableCell(withIdentifier: "optionCell")
            cell?.textLabel?.text = objMessage.arrPossibleOutcomes[indexPath.row - 1]
            return cell!
        }else { //indexPath.row == objMessage.arrPossibleOutcomes.count + 1
            let cell = tableView.dequeueReusableCell(withIdentifier: "postResopnseCell")
            cell?.accessoryType = .none
            let button = cell?.viewWithTag(1001) as! UIButton
            button.addTarget(self, action: #selector(self.postResponse), for: .touchUpInside)
            return cell!
        }
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        if indexPath.row > 0 && indexPath.row <= objMessage.arrPossibleOutcomes.count, let cell = tableView.cellForRow(at: indexPath){
            cell.accessoryType = .none
            objMessage.strSelectedOutcome = ""
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 || indexPath.row == objMessage.arrPossibleOutcomes.count + 1{
            return
        }else{
            let cell = tableView.cellForRow(at: indexPath)
            cell?.accessoryType = .checkmark
            objMessage.strSelectedOutcome = cell?.textLabel?.text
        }
    }
    
    func postResponse(){
        if let _ = objMessage.strSelectedOutcome, let _ = objMessage.strSelectedOutcome?.characters.count {
            MessageResponder().postReply(toMessage: self.objMessage) { [weak self] (status, error)in
                self?.navigationController?.popViewController(animated: true)
            }
        }
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
