//
//  UserClass.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/23/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import Foundation

class UserClass {
    
    //    var role : String
    //    var first_name : String
    //    var last_name : String
    //    var mobile : String
    //    var user_email : String
    //    var user_login : String
    //    var user_pass : String
    //    var repeat_pass : String
    //    var sms_active_code : String
    
    var role = ""
    var first_name = ""
    var last_name = ""
    var mobile = ""
    var user_email = ""
    var user_login = ""
    var user_pass = ""
    var repeat_pass = ""
    var sms_active_code = ""
    
    
    
    
    init(therole : String , theFirst_name : String , theLast_name : String , theMobile : String , theUser_email : String , theuser_login : String , theuser_pass : String , theRepeat_pass : String , theSms_active_code : String) {
        self.role = therole
        self.first_name = theFirst_name
        self.last_name = theLast_name
        self.mobile = theMobile
        self.user_email = theUser_email
        self.user_login = theuser_login
        self.user_pass = theuser_pass
        self.repeat_pass = theRepeat_pass
        self.sms_active_code = theSms_active_code
        
    }
    
//        convenience init(therole : String , theFirst_name : String , theLast_name : String , theMobile : String , theUser_email : String , theuser_login : String , theuser_pass : String , theRepeat_pass : String , theSms_active_code : String ) {
//            self.init()
//
//            self.role = therole
//            self.first_name = theFirst_name
//            self.last_name = theLast_name
//            self.mobile = theMobile
//            self.user_email = theUser_email
//            self.user_login = theuser_login
//            self.user_pass = theuser_pass
//            self.repeat_pass = theRepeat_pass
//            self.sms_active_code = theSms_active_code
    
    
      //  }

}
