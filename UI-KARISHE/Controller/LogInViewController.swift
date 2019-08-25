//
//  LogInViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/28/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import SCLAlertView
import CoreData

class LogInViewController: UIViewController , UITextFieldDelegate {
    
    @IBOutlet weak var logInUserId: UITextField!
    @IBOutlet weak var LogInUserPass: UITextField!
    @IBOutlet weak var goToRegisterPageButt: UIButton!
    @IBOutlet weak var forgotPassButt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogInViewController()
        
    }
    
    //MARK: - Set Up View
    fileprivate func setupLogInViewController() {
        let dictionaryOfTextField = [1 : logInUserId,2 : LogInUserPass]
        setDoneButtInKeyBoards(funcDictionary: dictionaryOfTextField)
        
         _ = textFieldShouldReturn(LogInUserPass)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true)
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
    
    fileprivate func setDoneButtInKeyBoards(funcDictionary : [Int : UITextField?]) {
        for (_,value) in funcDictionary {
            //  linerTF(newTextField: value!)
            doneButtMakerForKeyBoard(doneForTF: value!)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        let nextTag = textField.tag + 1
        
        if let nextResponder = textField.superview?.viewWithTag(nextTag) {
            nextResponder.becomeFirstResponder()
        } else {
            textField.resignFirstResponder()
        }
        return true
    }
    
    //MARK: - Tap Log in Butoon
    @IBAction func LogInMainButt(_ sender: UIButton) {
        view.endEditing(true)
        
        let homePage = self.storyboard?.instantiateViewController(withIdentifier: "empNavigationBar") as! empNavigationBar
        
        let parameters: [String: Any] = [
                    "ae_redirect_url": "https://www.karishe.com" ,
                    "user_login": logInUserId.text ?? "admin@admin.com" ,
                    "user_pass": LogInUserPass.text ?? "admin" ,
                    "remember": "on" ,
                    "do": "login" ,
                    "action": "ae-sync-user" ,
                    "method": "read" ]
        //Choose View after Login
        let pas = LoginCL()
        pas.logInFunc(urlOfFunc: "https://www.karishe.com/wp-admin/admin-ajax.php", parameters: parameters , user_pass: LogInUserPass.text ?? "admin", nv: homePage )
    }
}
    

