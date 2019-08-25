//
//  FrePageViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 8/24/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import CoreData

class FrePageViewController: UIViewController {
    var userInfos = [UserInfo]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    override func viewDidLoad() {
        super.viewDidLoad()

        loadCoreData()
        let newS : String = userInfos[0].userRole! + userInfos[0].showName!
        textLabel.text = newS
    }
    @IBOutlet weak var textLabel: UILabel!
    func loadCoreData() {
        let request : NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        do {
            userInfos = try context.fetch(request)
        } catch  {
            print("error in fetching data \(error)")
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
