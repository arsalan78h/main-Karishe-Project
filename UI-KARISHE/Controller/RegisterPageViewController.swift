//
//  RegisterPageViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/21/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class RegisterPageViewController: UIViewController {

    var roleChoosenByuser = ""
    var roleFlag : Bool = false
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupRegisterPageView()
        
    }
    func setupRegisterPageView() {
        
    }
    
    //employer
    @IBAction func employerButt(_ sender: Any) {
    roleFlag = true
        //performSegue(withIdentifier: "goForEmployer", sender: self)
        
    }
    //freelancer
    @IBAction func freelancerButt(_ sender: Any) {
       // performSegue(withIdentifier: "goForFreelancer", sender: self)
        roleFlag = false
        
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if roleFlag == true {
            roleChoosenByuser = "employer"
        }else {
            roleChoosenByuser = "freelancer"
        }
        let vc = segue.destination as! DoRegisterViewController
        vc.roleMainOfUser = roleChoosenByuser
        
        
    }
    
}
