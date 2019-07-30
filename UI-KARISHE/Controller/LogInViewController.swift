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
                    print("user name or password is wrong-please try again later")
                }
            }
//            guard let data = data,
//                let response = response as? HTTPURLResponse,
//                error == nil else {                                              // check for fundamental networking error
//                    print("error", error ?? "Unknown error")
//                    return
            }
            task.resume()
            
//            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
//                print("statusCode should be 2xx, but is \(response.statusCode)")
//                print("response = \(response)")
//                return
//            }
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(String(describing: responseString))")
//            print("---------------------------------------------------------")
//
//            let charResponseString = Array(responseString!)
        
//            if charResponseString[11] == "f" {
//                print("username or passWord is wrong")
//                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
//            } else {
//                self.checkToken()
//                print("remove activityyyyyyy")
//                self.removeActivityIndicator(activityIndicator: myActivityIndicator)
//            }
        }
    
    
    
    func removeActivityIndicator(activityIndicator: UIActivityIndicatorView)
    {
        DispatchQueue.main.async
            {
                activityIndicator.stopAnimating()
                activityIndicator.removeFromSuperview()
        }
    }
    
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
                
              //  print(user ?? "default value")
                print("-------------------------------")
                print(user?.token ?? "admin")
            }
                
            
//                let response = response as? HTTPURLResponse,
//                error == nil else {                                              // check for fundamental networking error
//                    print("error", error ?? "Unknown error")
//                    return
//            }
            
//            guard (200 ... 299) ~= response.statusCode else {                    // check for http errors
//                print("statusCode should be 2xx, but is \(response.statusCode)")
//                print("response = \(response)")
//                return
//            }
            
//            let responseString = String(data: data, encoding: .utf8)
//            print("responseString = \(String(describing: responseString))")
           // let charResponseString = Array(responseString!)
            
            
        }
        task.resume()
        
        
        
    }
    


}
