//
//  verifyPageViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/22/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class verifyPageViewController: UIViewController {
   
    @IBOutlet weak var verifyCodeTextfield: UITextField!
    
    @IBOutlet weak var returnButt: UIButton!
    
    
    
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
}
    
    
    @IBAction func verifyCodeButt(_ sender: Any) {
        
        let url = URL(string: "https://www.karishe.com/wp-admin/admin-ajax.php")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "ae_redirect_url":
            "role" : employer
            "first_name" : adsdasdasdas
            "last_name" : asdasdasdasd
            "mobile" : 09605145968
            "user_email" : arsalanh@yahoo.com
            "user_login" : sdasdasdasda
            "user_pass" : 123456
            "repeat_pass" : 123456
            "sms_active_code" : 654321
            "do" : "register"
            "action" : "ae-sync-user"
            "method" : "create"
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
            print("responseString = \(responseString)")
        }
        
        task.resume()
        
        
        
        
        
    }
    
    
    
    
    

}
