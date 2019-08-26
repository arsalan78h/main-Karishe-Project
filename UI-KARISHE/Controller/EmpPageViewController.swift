//
//  HomePageViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/31/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
class EmpPageViewController: UIViewController {
    
    @IBOutlet weak var exampleLabel: UILabel!
    
  //  var userInfos = [UserInfo]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        var userInfos = loadCoreData()
        let newS : String = userInfos[0].userRole! + userInfos[0].showName!
        exampleLabel.text = newS
    }
    
    @IBAction func logOutExampel(_ sender: Any) {
        showActivityIndicator("" , haveBlurEffect: false)
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            KeychainWrapper.standard.removeAllKeys()
            deleteDataBase()
            let homePage = self.storyboard?.instantiateViewController(withIdentifier: "firstNavigationBar") as! firstNavigationBar
            DispatchQueue.main.async
                {
                    self.present(homePage, animated: true, completion: nil)
            }
        }
    }
    
    
    
    
}
