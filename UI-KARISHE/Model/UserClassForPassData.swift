//
//  UserClass.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/23/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import Foundation

class UserClassForPassData {
    
    var role = ""
    var first_name = ""
    var last_name = ""
    var mobile = ""
    var user_email = ""
    var user_login = ""
    var user_pass = ""
 //   var repeat_pass = ""
    var sms_active_code = ""
    
    init() {
        role = "anyRole"
        first_name = "admin"
        last_name = "admin"
        mobile = "00000000000"
        user_email = "admin@admin.com"
        user_login = "admin admin"
        user_pass = "admin"
        sms_active_code = "000000"
    }
    
   convenience init(therole : String , theFirst_name : String , theLast_name : String , theMobile : String , theUser_email : String , theuser_login : String , theuser_pass : String , theRepeat_pass : String , theSms_active_code : String) {
        self.init()
        role = therole
        first_name = theFirst_name
        last_name = theLast_name
        mobile = theMobile
        user_email = theUser_email
        user_login = theuser_login
        user_pass = theuser_pass
     //   self.repeat_pass = theRepeat_pass
        sms_active_code = theSms_active_code
        
    }
    
}
