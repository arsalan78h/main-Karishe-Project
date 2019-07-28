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
    
    
    var saveUserData = UserClassForPassData(therole: "", theFirst_name: "", theLast_name: "", theMobile: "", theUser_email: "", theuser_login: "", theuser_pass: "", theRepeat_pass: "", theSms_active_code: "")
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupVerifyPageViewController()
        
}
    func setupVerifyPageViewController() {
        
        verifyCodeTextfield.textContentType = .oneTimeCode
        
    }
    @IBAction func verifyCodeButt(_ sender: Any) {

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
            "repeat_pass" : saveUserData.repeat_pass ,
            "sms_active_code" : verifyCodeTextfield.text ?? 000000 ,
            "do" : "register" ,
            "action" : "ae-sync-user" ,
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
            print("responseString = \(String(describing: responseString))")
            
            _ = String(data: data, encoding: .utf8)
            print("responseString = \(String(describing: responseString))")
            let charResponseString = Array(responseString!)
            
            if charResponseString[11] == "f" {
                DispatchQueue.main.async {
//                    _ = SCLAlertView().showError("مشکل در اطلاعات وارد شده", subTitle:"لطفاهمه اطلاعات را وارد کنید", closeButtonTitle:"تایید")
                    _ = SCLAlertView().showError("کد وارد شده اشتباه است")
                }
            }else{
                DispatchQueue.main.async {
                    let appearance = SCLAlertView.SCLAppearance(
                        showCloseButton: false)
                    let alertView = SCLAlertView(appearance: appearance)
                    alertView.addButton("ورود", target:self, selector:Selector(("enterButt")))
                    alertView.showSuccess("ارسال کد", subTitle:"ثبت نام باموفقیت انجام شد")
                }
            }
        }
        task.resume()
    }
//    @objc func enterButt() {
//        let nextVc = self.storyboard?.instantiateViewController(withIdentifier: "LogInViewControllerID") as! LogInViewController
//        self.navigationController?.pushViewController(nextVc, animated: true)
//    }
}







