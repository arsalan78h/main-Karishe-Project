//
//  LogInViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/28/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInUserId: UITextField!
    @IBOutlet weak var LogInUserPass: UITextField!
    @IBOutlet weak var goToRegisterPageButt: UIButton!
    @IBOutlet weak var forgotPassButt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogInViewController()
    }
    
    fileprivate func setupLogInViewController() {
        
        
    
    }
    
    @IBAction func LogInMainButt(_ sender: UIButton) {
        
        let url = URL(string: "https://www.karishe.com/wp-admin/admin-ajax.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "ae_redirect_url": "https://www.karishe.com" ,
            "user_login": logInUserId.text ?? "admin@admin.com" ,
            "user_pass": LogInUserPass.text ?? "adimn" ,
            "remember": "on" ,
            "do": "login" ,
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
        }
        task.resume()
    }
    


}
