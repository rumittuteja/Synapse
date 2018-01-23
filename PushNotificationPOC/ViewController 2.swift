//
//  ViewController.swift
//  ARKit
//
//  Created by Rumit Singh Tuteja on 10/31/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import ResearchKit
import Alamofire
class ViewController: ParentViewController,ORKTaskViewControllerDelegate {
    var surveyTask:SurveyTask! = SurveyTask()
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchSurveyQuestions()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func taskViewController(_ taskViewController: ORKTaskViewController, didFinishWith reason: ORKTaskViewControllerFinishReason, error: Error?) {
        if reason == .completed, let results = taskViewController.result.results {
            for result in results {
//                switch result.identifier {
//                case <#pattern#>:
//                    <#code#>
//                default:
//                    <#code#>
//                }
                print("result : \(result)")
            }
        }
        //Handle results with taskViewController.result
        taskViewController.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func surveyTapped(_ sender: Any) {
        let taskViewController = ORKTaskViewController(task: self.surveyTask.surveyTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    @IBAction func consentTapped(sender : AnyObject) {
        let taskViewController = ORKTaskViewController(task: ConsentTask().consentTask, taskRun: nil)
        taskViewController.delegate = self
        present(taskViewController, animated: true, completion: nil)
    }
    
    func postSurvey(){
        
    }
    
    func fetchSurveyQuestions(){
        Alamofire.request(
            URL(string: "http://18.220.163.207:8080/getSurveyQuestion")!,
            method: .get,
            parameters: [:])
            .responseJSON { (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                    return
                }
                if let dictResponse = response.result.value as? [String:Any]{
                    if let status = dictResponse["status"] as? String{
                        if status == "200", let arrSurveys = dictResponse["SurveyQuestions"] as? [[String:Any]] {
                            self.surveyTask.dictSurvey = arrSurveys.first
                        }
                    }                
                }
        }

    }

}

