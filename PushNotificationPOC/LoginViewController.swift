//
//  LoginViewController.swift
//  ARKit
//
//  Created by Rumit Singh Tuteja on 11/8/17.
//  Copyright © 2017 Rumit Singh Tuteja. All rights reserved.
//

import UIKit
import Alamofire

class LoginViewController: ParentViewController, UITextFieldDelegate {

    @IBOutlet weak var btnLogin: UIButton!
    @IBOutlet weak var txtFieldEmail: UITextField!
    @IBOutlet weak var txtFieldPassword: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.btnLogin.layer.cornerRadius = 15.0
        checkForSessionInfoAndDoAccordingly()
        // Do any additional setup after loading the view.
    }
    
    func checkForSessionInfoAndDoAccordingly(){
        // check if session is present in the commons object
//        self.performSegue(withIdentifier: "login", sender: self)
        if let _ = Commons.objUser, let _ = Commons.objUser.sessionToken {
            logUserIntoTheApp()
        }
    }
    
    func validCredentials() -> Bool{
        return !(self.txtFieldEmail.text?.isEmpty)! && !(self.txtFieldPassword.text?.isEmpty)!
    }
    @IBAction func btnLoginAction(_ sender: Any) {
        
        if validCredentials(){
            logUserIn()
            // hit service and from response call the following method
            //            checkForSessionInfoAndDoAccordingly()
        }else{
            Commons.displayAlert(withTitle: "Invalid Credentials", message: "Please check the enterd email ID and password and try again.")
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func logUserIn(){
        let email:String = self.txtFieldEmail.text!
        let password:String = self.txtFieldPassword.text!
        let params = ["emailID":email,"password":password]
        let urlString = WebAPIs.baseURL + "/login"
        Alamofire.request(
            URL(string: urlString)!,
            method: .post,
            parameters: params)
            .validate(contentType: ["application/json"])
            .responseJSON { [weak self] (response) -> Void in
                guard response.result.isSuccess else {
                    print("Error while fetching remote rooms: \(response.result.error)")
                    return
                }
                guard let responseJSON = response.result.value as? [String: Any] else {
                    print("Invalid tag information received from the service")
                    
                    return
                }
                print(responseJSON)
                
                if let status = responseJSON["status"] as? String {
                    if status == "200" {
                        var dictionary = responseJSON["userDetails"] as! [String:Any]
                        dictionary["token"] = responseJSON["token"] as! String
                        let user = User(withParams:dictionary)
                        UserDefaults.standard.set(dictionary, forKey: "session")
                        Commons.objUser = user
                        print("Hello")
                        self?.logUserIntoTheApp()
                        
                    }else{
                        Commons.displayAlert(withTitle: "SERVER ERROR", message: "Couldn't login at this time, please try again.")
                    }
                    
                }
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == self.txtFieldEmail {
            self.txtFieldPassword.becomeFirstResponder()
            return false
        }else if textField == self.txtFieldPassword {
            if validCredentials(){
                logUserIn()
                // hit service and from response call the following method
                //            checkForSessionInfoAndDoAccordingly()
            }else{
                Commons.displayAlert(withTitle: "Invalid Credentials", message: "Please check the enterd email ID and password and try again.")
            }
            return true
        }
        return true
    }
    
    func pushViewController(){
        let storyboard = UIStoryboard(name:"Main", bundle:nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "studiesList")
        self.navigationController?.pushViewController(vc, animated: true)
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
