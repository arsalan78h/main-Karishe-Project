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

class LogInViewController: UIViewController {
    
    @IBOutlet weak var logInUserId: UITextField!
    @IBOutlet weak var LogInUserPass: UITextField!
    @IBOutlet weak var goToRegisterPageButt: UIButton!
    @IBOutlet weak var forgotPassButt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupLogInViewController()
    }
    
    var myUsers = LoginClass(success: false, data: LoginDataClass(id: "", userLogin: "", userNicename: "", userEmail: "", userURL: "", userRegistered: "", userStatus: "", displayName: "", etBanExpired: "", etBanNote: "", location: "", address: "", phone: "", mobile: "", etAvatar: "", etAvatarURL: "", postCount: "", commentCount: "", hourRate: "", facebook: "", twitter: "", registerStatus: "", banned: false, userHourRate: "", userProfileID: "", userCurrency: "", userSkills: "", userAvailable: "", paypal: "", avatar: "", avatarMobile: "", joinDate: "", firstName: "", lastName: "", dataDescription: "", label: "", authorURL: "", ajaxnonce: "", logoajaxnonce: "", dataID: "", banExpired: "", banNote: "", msg: "", redirectURL: "", dataDo: ""), msg: "")
    
    
    fileprivate func setupLogInViewController() {
        
        
    
    }
    
    var privatePass : String = "admin"
    
    @IBAction func LogInMainButt(_ sender: UIButton) {
        
        privatePass = LogInUserPass.text ?? "admin"
        
        
        let myActivityIndicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        myActivityIndicator.center = view.center
        myActivityIndicator.hidesWhenStopped = false
        myActivityIndicator.startAnimating()
        view.addSubview(myActivityIndicator)
        
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
            if let data = data {
                
                self.myUsers = try! JSONDecoder().decode(LoginClass.self, from: data)
                
                if self.myUsers.success == true {
                    self.checkToken()
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                } else {
                    //alert
                    self.removeActivityIndicator(activityIndicator: myActivityIndicator)
                    SCLAlertView().showError("اطلاعات وارد شده نادرست است! ", subTitle: "لطفا دوباره سعی کنید")
                }
            } else {
                SCLAlertView().showError("خطا در ارتباط یا سیستم", subTitle: "لطفا دوباره سعی کنید")
        }
    }
            task.resume()
}
    
////////////////////////////////////////////////////////////////////////////////////////
    func checkToken(){
        
        let url = URL(string: "http://www.karishe.ir/wp-json/aam/v1/authenticate")!
        var request = URLRequest(url: url)
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")
        request.httpMethod = "POST"
        let parameters: [String: Any] = [
            "username": self.myUsers.data.userLogin ,  //"User-142973"
            "password": privatePass ,  //"arsalan7878"
        ]
        request.httpBody = parameters.percentEscaped().data(using: .utf8)
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            
            if let data = data {
                let user = try? JSONDecoder().decode(TokenClass.self, from: data)
                
                print("-------------------------------")
                print(user?.token ?? "admin")
                
                let accessToken = user?.token
                if (accessToken?.isEmpty)! {
                    SCLAlertView().showError("خطا در ارتباط یا سیستم", subTitle: "لطفا دوباره سعی کنید")
                } else {
                    let saveAccesssToken: Bool = KeychainWrapper.standard.set(accessToken!, forKey: "accessToken")
                    if saveAccesssToken {
                        self.goToHomePage()
                        
                    }else{
                        SCLAlertView().showError("خطا در ارتباط یا سیستم", subTitle: "لطفا دوباره سعی کنید")
                    }
                }
            }
        }
    task.resume()
}
////////////////////////////////////////////////////////////////////////////////////////
    
   func goToHomePage() {
    
    DispatchQueue.main.async
        {
            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "mainNavigationBar") as! mainNavigationBar
            let appDelegate = UIApplication.shared.delegate
            appDelegate?.window??.rootViewController = homePage
    }
}
    
//////////////////////////////////////////////////////////////////////////////////////
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }

    
    
    
    
}





//let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
//request.addValue("Bearer \(accessToken!)", forHTTPHeaderField: "Authorization")
