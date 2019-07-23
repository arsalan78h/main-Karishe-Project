//
//  DoRegisterViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/21/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class DoRegisterViewController: UIViewController {

    
    @IBOutlet weak var userFName: UITextField!
    @IBOutlet weak var userLName: UITextField!
    @IBOutlet weak var userPhoneNum: UITextField!
    @IBOutlet weak var userMail: UITextField!
    @IBOutlet weak var userProfileName: UITextField!
    @IBOutlet weak var userPassWord: UITextField!
    @IBOutlet weak var userVerifyPass: UITextField!
    
    @IBOutlet weak var rulesLabel: UILabel!
    
    var roleMainOfUser = "" //AZ VIEW CONTROLLE GHABLI BAYAD ROLE LO PASS BEDIM TOO IN CONTROLLER VA BAD OONO BEZARIM INJA
    
    var inputUserData = UserClass(therole: "", theFirst_name: "", theLast_name: "", theMobile: "", theUser_email: "", theuser_login: "", theuser_pass: "", theRepeat_pass: "", theSms_active_code: "")
    
////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDoRegisterViewController()
        navigationItem.title = roleMainOfUser
    }
    
// MARK: - SETUP VIEW/////////////////////////////////////////////////////////////////
   func setUpDoRegisterViewController() {
    
    let arrayOfTextField = [1 : userFName,2 : userLName,3 : userPhoneNum,4  :userPhoneNum,5 : userMail,6 : userProfileName,7 : userPassWord,8 : userVerifyPass]
    
    for (_,value) in arrayOfTextField {
        linerTF(newTextField: value!)
    }
    
}
    func linerTF(newTextField : UITextField) {
        let newLayer = CALayer()
        newLayer.frame = CGRect(x: 0, y: newTextField.frame.height , width: newTextField.frame.width , height: 2)
        
        newLayer.backgroundColor = UIColor(red: 0/255, green: 51/255, blue: 78/255, alpha: 1).cgColor
        
        newTextField.borderStyle = .none
        newTextField.layer.addSublayer(newLayer)
        
    }
////////////////////////////////////////////////////////////////////////////////////
    @IBAction func registerButt(_ sender: Any) {
        
        if (userPhoneNum.hasText == false || userProfileName.hasText == false || userMail.hasText == false) {
            //alert
            DispatchQueue.main.async {
                 _ = SCLAlertView().showError("مشکل در اطلاعات وارد شده", subTitle:"لطفاهمه اطلاعات را وارد کنید", closeButtonTitle:"تایید")
            }
           
            print("please complete information")
        } else {
            
            let url = URL(string: "https://www.karishe.com/wp-admin/admin-ajax.php")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let parameters: [String: Any] = [
                "action": "sms_check_mobile",
                "mobile": userPhoneNum.text ?? "00000000000",
                "login": userProfileName.text ?? "admin",
                "email": userMail.text ?? "admin"
            ]
            
            request.httpBody = parameters.percentEscaped().data(using: .utf8)
            DispatchQueue.main.async {
                let task = URLSession.shared.dataTask(with: request) { data, response, error in
                    guard let data = data,
                        let response = response as? HTTPURLResponse,
                        error == nil else {                                              // check for networking erro
                            print("error", error ?? "Unknown error")
                            return
                    }
                    
                    guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
                        print("statusCode should be 2xx, but is \(response.statusCode)")
                        print("response = \(response)")
                        return
                    }
                    
                    let responseString = String(data: data, encoding: .utf8)
                    let charResponseString = Array(responseString!)
                    // phone - userName - Email
                    if responseString == "000" {
                        //alert
                        DispatchQueue.main.async {
                        print("you can create new account")
                            
                            let appearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false)
                            let alertView = SCLAlertView(appearance: appearance)
                            alertView.showSuccess("No button", subTitle: "create no butt success alert")
                            alertView.addButton("First Button", target:self, selector:Selector(("firstButton")))
                            alertView.showSuccess("ارسال کد", subTitle: "کد تایید برای شما ارسال شد")
                        }
                    }else if charResponseString[0] == "1" {
                        //alert
                        DispatchQueue.main.async {
                             _ = SCLAlertView().showWarning("توجه", subTitle: "این شماره موبایل قبلا ثیت شده")
                        }
                       
                        print("there is phone number")
                        
                    }else if charResponseString[1] == "1" {
                        //alert
                        DispatchQueue.main.async {
                           _ = SCLAlertView().showWarning("توجه", subTitle: "این نام کاربری قبلا ثبت شده")
                        }
                        print("there is user name ")
                        
                    }else if charResponseString[2] == "1" {
                        //alert
                        DispatchQueue.main.async {
                            _ = SCLAlertView().showWarning("توجه", subTitle: "این ایمیل قبلا ثبت شده ")
                        }
                        print("there is email")
                    }
                }
                task.resume()
            }
        }
    }
////////////////////////////////////////////////////////////////////////////////////
    @objc func firstButton() {
//        let secondVC = self.storyboard?.instantiateViewController(withIdentifier: "verifyPageViewController") as? verifyPageViewController
//        self.navigationController?.pushViewController(secondVC!, animated: true)
       // self.nameOfUser = userFName.text ?? "default value"
        userDataPassing()
        performSegue(withIdentifier: "passdata", sender: self)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let vc = segue.destination as! verifyPageViewController
        vc.saveUserData.role = inputUserData.role
        vc.saveUserData.first_name = inputUserData.first_name
        vc.saveUserData.last_name = inputUserData.last_name
        vc.saveUserData.mobile = inputUserData.mobile
        vc.saveUserData.user_email = inputUserData.user_email
        vc.saveUserData.user_login = inputUserData.user_login
        vc.saveUserData.user_pass = inputUserData.user_pass
    }
////////////////////////////////////////////////////////////////////////////////////
    func userDataPassing() {
        inputUserData.role = roleMainOfUser
        inputUserData.first_name = userFName.text!
        inputUserData.last_name = userLName.text!
        inputUserData.mobile = userPhoneNum.text!
        inputUserData.user_email = userMail.text!
        inputUserData.user_login = userProfileName.text!
        inputUserData.user_pass = userPassWord.text!
        // don't pass verify user pass(same user pass and verify user pass)
    }
    //try animation alert later
}
