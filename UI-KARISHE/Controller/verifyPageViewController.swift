//
//  verifyPageViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/22/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SCLAlertView

class verifyPageViewController: UIViewController {
   
    @IBOutlet weak var verifyCodeTextfield: UITextField!
    
    var saveUserData = UserClassForPassData(therole: "", theFirst_name: "", theLast_name: "", theMobile: "", theUser_email: "", theuser_login: "", theuser_pass: "", theRepeat_pass: "", theSms_active_code: "")
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVerifyPageViewController()
        
}
    //MARK: - SetUp View ///////////////////////////////////////////////////
    func setupVerifyPageViewController() {
        
       // verifyCodeTextfield.textContentType = .oneTimeCode
        
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func keyboardWillHide() {
        self.view.frame.origin.y = 0
    }
    
    @objc func keyboardWillChange(notification: NSNotification) {
        
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if (verifyCodeTextfield.isFirstResponder) {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - Tap done Button
    @IBAction func verifyCodeButt(_ sender: Any) {
        view.endEditing(true)
        showActivityIndicator("انجام عملیات...", haveBlurEffect: false)
        
        let url = URL(string: "https://www.karishe.com/wp-admin/admin-ajax.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "role" : saveUserData.role ,
            "first_name"  : saveUserData.first_name ,
            "last_name" : saveUserData.last_name ,
            "mobile" : saveUserData.mobile ,
            "user_email" : saveUserData.user_email ,
            "user_login" : saveUserData.user_login ,
            "user_pass"  : saveUserData.user_pass ,
            "repeat_pass" : saveUserData.user_pass ,
            "sms_active_code" : verifyCodeTextfield.text ?? 000000 ,
            "do" : "register" ,
            "action" : "ae-sync-user" ,
            "method" : "create"]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            guard let data = data,
                let response = response as? HTTPURLResponse,
                error == nil else {                                              // check for fundamental networking error
                    print("error", error ?? "Unknown error")
                    return
            }

            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                print("statusCode should be 2xx, but is \(response.statusCode)")
                print("response = \(response)")
                return
            }

            let responseString = String(data: data, encoding: .utf8)
            
            _ = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            let charResponseString = Array(responseString!)
            
            if charResponseString[11] == "f" {
                DispatchQueue.main.async {
                    _ = SCLAlertView().showError("کد وارد شده اشتباه است", subTitle:"", closeButtonTitle:"تایید")
                    self.hideActivityIndicator()
                }
            }else{
                //
                DispatchQueue.main.async {
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false)
                    let alertView = SCLAlertView(appearance: appearance)
                    alertView.addButton("ورود", target:self, selector:Selector(("enterButt")))
                    alertView.showSuccess("ثبت نام باموفقیت انجام شد", subTitle:"")
                    self.hideActivityIndicator()
                }
            }
        }
        task.resume()
    }
    @objc func enterButt() {
//        DispatchQueue.main.async {
//            self.showActivityIndicator("انجام عملیات...")
//        }
        let parameters: [String: Any] = [
            "ae_redirect_url": "https://www.karishe.com" ,
            "user_login": saveUserData.user_email ,
            "user_pass": saveUserData.user_pass ,
            "remember": "on" ,
            "do": "login" ,
            "action": "ae-sync-user" ,
            "method": "read"
        ]
        
        let pas = LoginCL()
        
        if saveUserData.role == "employer" {
            print("enter as a employer")
        let empPage = self.storyboard?.instantiateViewController(withIdentifier: "empNavigationBar") as! empNavigationBar
            pas.logInFunc(urlOfFunc: "https://www.karishe.com/wp-admin/admin-ajax.php", parameters: parameters , user_pass: saveUserData.user_pass, nv: empPage )
        }
        
        else if saveUserData.role == "freelancer" {
            print("enter as a freelancer")
            let frePage = self.storyboard?.instantiateViewController(withIdentifier: "freNavigationBar") as! freNavigationBar
            pas.logInFunc(urlOfFunc: "https://www.karishe.com/wp-admin/admin-ajax.php", parameters: parameters , user_pass: saveUserData.user_pass, nv: frePage )
        }
    }
    
    
    
    
    
    
    
    
}





