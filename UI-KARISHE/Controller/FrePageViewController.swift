//
//  FrePageViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 8/24/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper

class FrePageViewController: UIViewController {
    var userInfos = [UserInfo]()
    
    @IBOutlet weak var textLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        var userInfos = loadCoreData()
        let newS : String = userInfos[0].userRole! + userInfos[0].showName!
        textLabel.text = newS
    }

    @IBAction func logOutAccount(_ sender: Any) {
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
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
