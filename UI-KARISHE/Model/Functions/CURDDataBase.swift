//
//  DataBaseExtentions.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 8/26/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//
//import Foundation
import UIKit
import CoreData


        func deleteDataBase() {
            //Clean Data Base
            let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
            let deleteFetch = NSFetchRequest<NSFetchRequestResult>(entityName: "UserInfo")
            let deleteRequest = NSBatchDeleteRequest(fetchRequest: deleteFetch)
            do{
                try context.execute(deleteRequest)
            }
            catch{
                print ("There was an error")
            }
   }

func saveCoreData() {
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    do {
        try context.save()
    } catch  {
        print("error in saving core data \(error)")
    }
}

func loadCoreData() -> [UserInfo] {
    var userInfos = [UserInfo]()
    let context = ( UIApplication.shared.delegate as! AppDelegate ).persistentContainer.viewContext
    let request : NSFetchRequest<UserInfo> = UserInfo.fetchRequest()
    do {
        userInfos = try context.fetch(request)
    } catch  {
        print("error in fetching data \(error)")
    }
    return userInfos
}

