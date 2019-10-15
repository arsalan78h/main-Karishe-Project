//
//  AppDelegate.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/20/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import CoreData
@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
      //  print(FileManager.default.urls(for: .documentDirectory, in: .userDomainMask))
        
        //MARK: - LogOut from account
      //  KeychainWrapper.standard.removeAllKeys()
//        func resetAllRecords(in entity : String) // entity = Your_Entity_Name
//        {
                //Clean Data Base
//                let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
//                let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
//                let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
//                do
//                {
//                    try context.execute(deleteRequest)
//                }
//                catch
//                {
//                    print ("There was an error")
//                }
     //   }
////////////////////////////////////////////////////////////////////////////////
        let accessToken: String? = KeychainWrapper.standard.string(forKey: "accessToken")
        if accessToken != nil {
              // Take user to a home page
            let mainStoryboard:UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let homePage = mainStoryboard.instantiateViewController(withIdentifier: "empNavigationBar") as! empNavigationBar
            self.window?.rootViewController = homePage
        }
        return true
    }
/////////////////////////////////////////////////////////////////////////////////
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        self.saveContext()
    }
    
    // MARK: - Core Data stack
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "UserInfoDB")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    // MARK: - Core Data Saving support
    
    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }
}

