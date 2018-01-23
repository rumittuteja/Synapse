    //
//  MessagesViewControler.swift
//  PushNotificationPOC
//
//  Created by Rumit Singh Tuteja on 11/12/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import ResearchKit

enum MessageType:String {
    case Question, Reminder, Information
}

class MessagesViewControler: ParentViewController, UITableViewDelegate, UITableViewDataSource, ORKTaskViewControllerDelegate {
    /**
     Tells the delegate that the task has finished.
     
     The task view controller calls this method when an unrecoverable error occurs,
     when the user has canceled the task (with or without saving), or when the user
     completes the last step in the task.
     
     In most circumstances, the receiver should dismiss the task view controller
     in response to this method, and may also need to collect and process the results
     of the task.
     
     @param taskViewController  The `ORKTaskViewController `instance that is returning the result.
     @param reason              An `ORKTaskViewControllerFinishReason` value indicating how the user chose to complete the task.
     @param error               If failure occurred, an `NSError` object indicating the reason for the failure. The value of this parameter is `nil` if `result` does not indicate failure.
     */
    public func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        print("finished with reason \(reason.rawValue)")
        if taskViewController.title == "Consent" {
            if reason == .completed {
                taskViewController.dismiss(animated: true) {
                    self.displayStartSurveyAlertAlert()
                }
            }else if reason == .discarded || reason == .failed {
                //### alert please come back and take the survey again
                taskViewController.dismiss(animated: true) {
                }
            }
        }else if taskViewController.title == "Survey" {
            taskViewController.dismiss(animated: true, completion: {
                let taskResult = taskViewController.result // this should be a ORKTaskResult
                let results = taskResult.results as! [ORKStepResult]//[ORKStepResult]
                let jsonObject: NSMutableDictionary = NSMutableDictionary()
                var dictionary = [String:Any]()
                for thisStepResult in results { // [ORKStepResults]
                    let stepResults = thisStepResult.results as! [ORKQuestionResult]
                    for item in stepResults {
                        print("result: \(String(describing: item.answer))")
                        jsonObject.setValue(item.answer, forKey: "\(String(describing: item.identifier))")
                    }
                    
                }
                
                let jsonData1: NSData
                var jsonString:String?
                do {
                    jsonData1 = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
                        jsonString = NSString(data: jsonData1 as Data, encoding: String.Encoding.utf8.rawValue) as? String
                    print("json string = \(jsonString)")
                    print("response: \(jsonData1)")
                } catch _ {
                    print ("JSON Failure")
                }
                
                
                
                let params = [
                    "title":self.surveyMsg!.strText ?? "",
                    "name":Commons.objUser.strName,
                    "email":Commons.objUser.strEmailID,
                    "surveyId": self.surveyMsg!.strSurveyID ?? "",
                    "study":self.surveyMsg!.strStudyID,
                    "owner": self.surveyMsg!.surveyOwner ?? "",
                    "answers":jsonString ?? ""
                    ] as [String : Any]
                
                SurveyResponseHandler().postSurveyResponse(withParams: params, completionhandler: { (dictResponse, error) in
                    if error == nil {
                        Commons.displayAlert(withTitle: "Response recorded!", message: "Thank you for taking time to fill out this survey. The information you have provided is of great value to us and shall be used only for the stated purposes.")
                    }
                })
            })
            //print("dictionary: \(dictionary)")
//            let jsonData1: NSData
//            do {
//                jsonData1 = try JSONSerialization.data(withJSONObject: jsonObject, options: JSONSerialization.WritingOptions()) as NSData
//                let jsonString = NSString(data: jsonData1 as Data, encoding: String.Encoding.utf8.rawValue) as! String
//                print("json string = \(jsonString)")
//                print("response: \(jsonData1)")
//                self.sendResponseToSurver(dictionary: jsonString)
//            } catch _ {
//                print ("JSON Failure")
//            }
            
        }
    }
    
    
     func displayStartSurveyAlertAlert(){
        let alertController = UIAlertController(title: "Start Survey", message: "Thank you for your consent to participate in this survey.", preferredStyle: .alert)
        let confirmAction = UIAlertAction(title: "Start now", style: .default, handler: {(_ action: UIAlertAction) -> Void in
            let taskViewController = ORKTaskViewController(task: SurveyTask().surveyTask, taskRun: nil)
            taskViewController.delegate = self
            taskViewController.title = "Survey"
            self.present(taskViewController, animated: true, completion: nil)
        })
        alertController.addAction(confirmAction)
//        let cancelAction = UIAlertAction(title: "Take it later"", style: .cancel, handler: {(_ action: UIAlertAction) -> Void in
//            
//        })
//        alertController.addAction(cancelAction)
        Commons.objRootNav.present(alertController, animated: true, completion: { _ in })
    }
    

    
    var surveyMsg:Message?
    @IBOutlet weak var tblViewMessages: UITableView!
    var arrMessages:[Message]?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tblViewMessages.register(UINib(nibName:"QuestionTableViewCell", bundle:nil), forCellReuseIdentifier: "questionCell")
        self.tblViewMessages.register(UINib(nibName:"OptionTableViewCell", bundle:nil), forCellReuseIdentifier: "optionCell")
        self.tblViewMessages.register(UINib(nibName:"ReminderTableViewCell", bundle:nil), forCellReuseIdentifier:"reminderCell")
        self.tblViewMessages.register(UINib(nibName:"InformationTableViewCell", bundle:nil), forCellReuseIdentifier: "infoCell")
        self.tblViewMessages.register(UINib(nibName:"SurveyTableViewCell", bundle:nil), forCellReuseIdentifier: "surveyCell")
//        self.tblViewMessages.register(QuestionTableViewCell.self, forCellReuseIdentifier: "questionCell")
//        self.tblViewMessages.register(OptionTableViewCell.self, forCellReuseIdentifier: "optionCell")
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchMessages()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if let messages = self.arrMessages {
            return messages.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let message = self.arrMessages?[section]{
            if let arrResponses = message.arrPossibleOutcomes{
                return arrResponses.count + 1
            }
        }
        return 1
    }
    
    func btnTakeSurvey(button:UIButton){
        if let message = arrMessages?[button
            .tag] {
            self.surveyMsg = message
            let params = ["surveyId": message.strSurveyID!,
            "study":message.strStudyID!]
            SurveyDataFetcher().fetchSurvey(withParams: params, completionhandler: { [weak self] (dictSurvey, error) in
                if let dictData = dictSurvey, error == nil {
                    Commons.dictSurvey = dictData["survey"] as! [String : Any]
                    let taskViewController = ORKTaskViewController(task: ConsentTask().consentTask, taskRun: nil)
                    taskViewController.delegate = self
                    taskViewController.title = "Consent"
                    self?.present(taskViewController, animated: true, completion: nil)
                }
            })
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let message = arrMessages?[indexPath.section]
        if message?.strType == "Information" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "infoCell") as! InformationTableViewCell
            cell.setInformation(forMessage: message)
            return cell
        }else if message?.strType == "Reminder"{
            let cell = tableView.dequeueReusableCell(withIdentifier: "reminderCell") as! ReminderTableViewCell
            cell.setReminder(forMessage: message)
            return cell
        }else if message?.strType == "Survey" {
            let cell = tableView.dequeueReusableCell(withIdentifier: "surveyCell") as! SurveyTableViewCell
            cell.setSurveyDetails(forMessage: message)
            cell.btnSurvey.addTarget(self, action: #selector(self.btnTakeSurvey(button:)), for: .touchUpInside)
            cell.btnSurvey.tag = indexPath.section
            return cell
        }else {
            if indexPath.row == 0 {
                let cell = self.tblViewMessages.dequeueReusableCell(withIdentifier: "questionCell") as! QuestionTableViewCell
                cell.selectionStyle = .none
                cell.lblQuestion.text = message?.strText
                return cell
            } else {
                //            if indexPath.row > 0 && indexPath.row <= (message?.arrPossibleOutcomes.count)! {
                let cell = self.tblViewMessages.dequeueReusableCell(withIdentifier: "optionCell") as! OptionTableViewCell
                cell.lblOption.text = message?.arrPossibleOutcomes[indexPath.row - 1]
                if message?.strSelectedOutcome == cell.lblOption.text {
//                    cell.lblBackView.backgroundColor = UIColor(red:112.0/255.0,green:67.0/255.0,blue:132.0/255.0,alpha:0.5)
                    cell.lblBackView.backgroundColor = UIColor(red:0.8,green:0.8,blue:0.8,alpha:1.0)

                    cell.lblOption.textColor = .white
                }else {
                    cell.lblOption.textColor = .black
                    cell.lblBackView.backgroundColor = .white
                }
                return cell
            }
            //        return cell
            //        else{
            //            let cell = self.tblViewMessages.dequeueReusableCell(withIdentifier: "postResopnseCell")
            //            let button = cell?.viewWithTag(1001) as! UIButton
            //            button.addTarget(self, action: #selector(postResponse(button:)), for: .touchUpInside)
            //            button.accessibilityHint = String(indexPath.section)
            //            return cell!
            //        }
        }
    }
    
    func postResponse(button:UIButton!){
        let objMessage = arrMessages?[Int(button.accessibilityHint!)!]
        if let _ = objMessage?.strSelectedOutcome, let _ = objMessage?.strSelectedOutcome?.characters.count {
            MessageResponder().postReply(toMessage: objMessage!) { [weak self] (status, error)in
                if error == nil {
                    self?.navigationController?.popViewController(animated: true)
                }else{
                     // alert - couldnt post response.
                }
            }
        }
    }
    
    func fetchMessages(){
        if userIsInSession() {
            MessagesFetcher().fetchMessages(withParams: nil) { (messages, error) in
                if messages != nil {
                    self.arrMessages = messages
                    self.tblViewMessages.reloadData()
                }
            }
        }
    }
    
//    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
//        let cell = tableView.cellForRow(at: indexPath)
//        if !(cell is OptionTableViewCell) {
//            return
//        }
//        let optionCell = cell as! OptionTableViewCell
//        optionCell.lblOption.textColor = .black
//    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        if !(cell is OptionTableViewCell) {
            return
        }
        if let objMessage = self.arrMessages?[indexPath.section] {
            objMessage.strSelectedOutcome = objMessage.arrPossibleOutcomes[indexPath.row - 1]
            MessageResponder().postReply(toMessage: objMessage) { (status, error)in
                self.tblViewMessages.reloadSections(IndexSet([indexPath.section]), with: .automatic)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return 55
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableViewAutomaticDimension
    }
    
}
