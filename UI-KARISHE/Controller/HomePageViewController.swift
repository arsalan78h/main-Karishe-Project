//
//  HomePageViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/31/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import CoreData
class HomePageViewController: UIViewController {
    
    @IBOutlet weak var exampleLabel: UILabel!
    
    var userInfos = [UserInfo]()
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //load user data from data base
        loadCoreData()
        
        exampleLabel.text = userInfos[0].showName
    }
    //MARK: -Load user data from data base
    func loadCoreData() {
        let request : NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
        do {
            userInfos = try context.fetch(request)
        } catch  {
            print("error in fetching data \(error)")
        }
    }
//    func loadcoreData(){
//
//        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
//        do {
//            let result = try context.fetch(fetchRequest)
//            for data in result as! [NSManagedObject] {
//                print(data.value(forKey: "login") as! String)
//                        }
//        } catch {
//            print("failed")
//        }
//    }
}
