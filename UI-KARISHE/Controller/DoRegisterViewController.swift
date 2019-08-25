//
//  DoRegisterViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/21/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SCLAlertView

class DoRegisterViewController: UIViewController , UITextFieldDelegate {

    @IBOutlet weak var userFName: UITextField!
    @IBOutlet weak var userLName: UITextField!
    @IBOutlet weak var userPhoneNum: UITextField!
    @IBOutlet weak var userMail: UITextField!
    @IBOutlet weak var userProfileName: UITextField!
    @IBOutlet weak var userPassWord: UITextField!
    @IBOutlet weak var userVerifyPass: UITextField!
    
    @IBOutlet weak var rulesLabel: UILabel!
    
    var roleMainOfUser = "" //AZ VIEW CONTROLLE GHABLI BAYAD ROLE LO PASS BEDIM TOO IN CONTROLLER VA BAD OONO BEZARIM INJA
    
    var inputUserData = UserClassForPassData(therole: "", theFirst_name: "", theLast_name: "", theMobile: "", theUser_email: "", theuser_login: "", theuser_pass: "", theRepeat_pass: "", theSms_active_code: "")
    
    
//    @IBAction func togglePassSecurity(_ sender: Any) {
//
//        userPassWord.isSecureTextEntry.toggle()
//    }
    
////////////////////////////////////////////////////////////////////////////////////
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpDoRegisterViewController()
    }
    
    //MARK: - setting up Keyboard /////////////////////////////////////
    
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
            if (userVerifyPass.isFirstResponder || userPassWord.isFirstResponder ) {
                self.view.frame.origin.y = -keyboardSize.height
            } else if userProfileName.isFirstResponder {
                self.view.frame.origin.y = -keyboardSize.height + 80
            }
        }
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        NotificationCenter.default.removeObserver(self, name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    func doneButtMakerForKeyBoard(doneForTF : UITextField) {
        let toolbar = UIToolbar(frame: CGRect(origin: .zero, size: .init(width: view.frame.size.width, height: 30)))
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButt = UIBarButtonItem(title: "Done", style: .done
            , target: self, action: #selector(doneButtonAction))
        toolbar.setItems([flexSpace , doneButt], animated: false)
        toolbar.sizeToFit()
        doneForTF.inputAccessoryView = toolbar
    }
    
    @objc func doneButtonAction() {
        self.view.endEditing(true)
    }
// MARK: - SETUP VIEW////////////////////////////////////////////////////////
   fileprivate func setUpDoRegisterViewController() {
    
    navigationItem.title = roleMainOfUser
    userMail.keyboardType = .emailAddress
    
    let dictionaryOfTextField = [1 : userFName,2 : userLName,3 : userPhoneNum,4  :userPhoneNum,5 : userMail,6 : userProfileName,7 : userPassWord,8 : userVerifyPass]
    setLineUnderTF(funcDictionary: dictionaryOfTextField)
    setDoneButtInKeyBoards(funcDictionary: dictionaryOfTextField)
    
     _ = textFieldShouldReturn(userFName)
    
}
    fileprivate func setLineUnderTF(funcDictionary : [Int : UITextField?]) {
        for (_,value) in funcDictionary {
            lineMakerForTF(newTextField: value!)
        }
    }
    
    fileprivate func setDoneButtInKeyBoards(funcDictionary : [Int : UITextField?]) {
        for (_,value) in funcDictionary {
            //  linerTF(newTextField: value!)
            doneButtMakerForKeyBoard(doneForTF: value!)
        }
    }
    
   fileprivate func lineMakerForTF(newTextField : UITextField) {
        let newLayer = CALayer()
        newLayer.frame = CGRect(x: 0, y: newTextField.frame.height , width: newTextField.frame.width , height: 2)
        
        newLayer.backgroundColor = UIColor(red: 0/255, green: 51/255, blue: 78/255, alpha: 1).cgColor
        
        newTextField.borderStyle = .none
        newTextField.layer.addSublayer(newLayer)
    }
    //Go next textField when tap next key on keyboard /////////////////////////
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //MARK: - Tap Register Button///////////////////////////////////////////////
    @IBAction func registerButt(_ sender: Any) {
        view.endEditing(true)
        if (userPhoneNum.hasText == false || userProfileName.hasText == false || userMail.hasText == false) {
            //alert
            DispatchQueue.main.async {
                 _ = SCLAlertView().showError("مشکل در اطلاعات وارد شده", subTitle:"لطفاهمه اطلاعات را وارد کنید", closeButtonTitle:"تایید")
            }
           
            print("please complete information")
        } else {
            
            let url = URL(string: "https://www.karishe.com/wp-json/wp/v2/check-user")!
            var request = URLRequest(url: url)
            request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
            request.httpMethod = "POST"
            
            let parameters: [String: Any] = [
          //      "action": "sms_check_mobile",
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
                  //  if responseString == "000" {
                        //alert
                    if (charResponseString[10] == "0") && (charResponseString[23] == "0") && (charResponseString[33] == "0") {
                        print("you can create new account")
                        DispatchQueue.main.async {
                        
                            
                            let appearance = SCLAlertView.SCLAppearance(
                                showCloseButton: false)
                            let alertView = SCLAlertView(appearance: appearance)
                            alertView.showSuccess("No button", subTitle: "create no butt success alert")
                            alertView.addButton("تایید", target:self, selector:Selector(("goToVerifyCodeVC")))
                            alertView.showSuccess("ارسال کد", subTitle: "کد تایید برای شما ارسال شد")
                        }
                        //10
                    }else if charResponseString[10] == "1" {
                        //alert
                        DispatchQueue.main.async {
                             _ = SCLAlertView().showWarning("توجه", subTitle: "این شماره موبایل قبلا ثیت شده")
                        }
                       
                        print("there is phone number")
                        //23
                    }else if charResponseString[23] == "1" {
                        //alert
                        DispatchQueue.main.async {
                           _ = SCLAlertView().showWarning("توجه", subTitle: "این نام کاربری قبلا ثبت شده")
                        }
                        print("there is user name ")
                        //33
                    }else if charResponseString[33] == "1" {
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
    @objc func goToVerifyCodeVC() {
        let nextVc = self.storyboard?.instantiateViewController(withIdentifier: "verifyPageViewController") as! verifyPageViewController
        passDataToNextVC(vc: nextVc)
        self.navigationController?.pushViewController(nextVc, animated: true)
    }
    func passDataToNextVC(vc : verifyPageViewController) {
        vc.saveUserData.role = roleMainOfUser
        vc.saveUserData.first_name = userFName.text!
        vc.saveUserData.last_name = userLName.text!
        vc.saveUserData.mobile = userPhoneNum.text!
        vc.saveUserData.user_email = userMail.text!
        vc.saveUserData.user_login = userProfileName.text!
        vc.saveUserData.user_pass = userPassWord.text!
    }
}
