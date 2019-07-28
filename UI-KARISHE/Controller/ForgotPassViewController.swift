//
//  ForgotPassViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/28/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class ForgotPassViewController: UIViewController {

    @IBOutlet weak var forgotPassTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    @IBAction func sendForgotButt(_ sender: UIButton) {
        
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
                        _ = SCLAlertView().showSuccess("ایمیل یا شماره وارد شده را برسی کنید")
                }
            }
        }
        task.resume()
        
        
    }
    
    

}
