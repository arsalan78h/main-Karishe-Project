//
//  ForgotPassViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/28/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SCLAlertView

class ForgotPassViewController: UIViewController {

    @IBOutlet weak var forgotPassTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    //MARK: - SetUp View
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
            if (forgotPassTextField.isFirstResponder) {
                self.view.frame.origin.y = -keyboardSize.height + 100
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    //MARK: - Tap ForGotPass Button
    @IBAction func sendForgotButt(_ sender: UIButton) {
        view.endEditing(true)
        
        let url = URL(string: "https://www.karishe.com/wp-admin/admin-ajax.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
        "user_login": forgotPassTextField.text ?? "admin@admin.com" ,
        "do": "forgot" ,
        "action": "ae-sync-user" ,
        "method": "read"
        ]
        
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
            print("responseString = \(String(describing: responseString))")
            
            let charResponseString = Array(responseString!)
            
            if charResponseString[11] == "f" {
                DispatchQueue.main.async {
                    _ = SCLAlertView().showError("دوباره سعی کنید", subTitle:"عبارت وارد شده در سیستم وجود ندارد", closeButtonTitle:"تایید")
                }
            }else {
                    DispatchQueue.main.async {
                        _ = SCLAlertView().showSuccess("ایمیل یا شماره وارد شده را برسی کنید", subTitle: "" , closeButtonTitle: "تایید")
                }
            }
        }
        task.resume()
    }
    
    

}
