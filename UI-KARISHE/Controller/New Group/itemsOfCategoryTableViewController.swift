//
//  itemsOfCategoryTableViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 9/18/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class itemsOfCategoryTableViewController: UITableViewController {
    
    
    var items = MobileDevJSON(data: [mobileDevDatum](), paginate: "T##String", msg: "<#T##String#>", success: false, maxNumPages: 0, total: "T##String")
    
    var slugpass : String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getDataForItemsOfCategories()
        
        
        print(slugpass)
        
    }
    var pageQuery = 1
    func getDataForItemsOfCategories(){
        let url = URL(string: "https://www.karishe.com/wp-admin/admin-ajax.php?query%5Bpost_type%5D=project&query%5Bpost_status%5D=publish&query%5Borderby%5D=et_budget&query%5Bplace_category%5D=&query%5Bmeta_key%5D=&query%5Bmeta_value%5D=&query%5Blocation%5D=&query%5Bshowposts%5D=&query%5Border%5D=DESC&query%5Bis_archive_project%5D=true&query%5Bpaginate%5D=page&page=1&paged=1&paginate=page&action=ae-fetch-projects&query%5Bproject_category%5D=\(slugpass)&query%5Bs%5D")
        
        
//        let queryParams : [String : String] = [
//
//            "query%5Bpost_type%5D" : "project" ,
//            "query%5Bpost_status%5D" : "publish" ,
//            "query%5Borderby%5D" : "et_budget" ,
//            "query%5Bplace_category%5D" : "" ,
//            "query%5Bmeta_key%5D" : "" ,
//            "query%5Bmeta_value%5D" : "" ,
//            "query%5Blocation%5D" : "" ,
//            "query%5Bshowposts%5D" : "" ,
//            "query%5Border%5D" : "DESC" ,
//            "query%5Bis_archive_project%5D" : "true" ,
//            "query%5Bpaginate%5D" : "page" ,
////            "page" : String(pageQuery) ,
//            "page" : "" ,
//            "paged" : "1" ,
//            "paginate" : "page" ,
//            "action" : "ae-fetch-projects" ,
//            "query%5Bproject_category%5D":"%d8%aa%d8%b1%d8%ac%d9%85%d9%87-%d9%88-%d8%aa%d9%88%d9%84%db%8c%d8%af-%d9%85%d8%ad%d8%aa%d9%88%d8%a7" ,
//            "query%5Bs%5D" : "" ,
//          //  "query%5Bskill%5D%5B%5D" : "287"
//        ]
        
//        var components = URLComponents()
//
//        var cs = CharacterSet.urlQueryAllowed
//        cs.remove("+")
//
//        components.scheme = "https"
//        components.host = "www.karishe.com"
//        components.path = "/wp-admin/admin-ajax.php"
//        components.percentEncodedQuery = queryParams.map {
//            $0.addingPercentEncoding(withAllowedCharacters: cs)!
//                + "=" + $1.addingPercentEncoding(withAllowedCharacters: cs)!
//            }.joined(separator: "&")
//
//        let finalURL = components.url
        
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do { if error == nil{
                self.items = try JSONDecoder().decode(MobileDevJSON.self, from: data!)
                //                for _ in self.items.data{  //MobileDev
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
                //                    }
                print("-------------------------------")
                for obj in self.items.data {
                    print("name of post : \(obj.postTitle)")
                }
                
                print("-------------------------------")
                let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                print(string1)
                print("-------------------------------")
                print(self.items.data[0].postTitle)
                print(self.items.data[5].postTitle)
                print(".....................................................")
                print(".....................................................")
                
                print(".....................................................")
                
                
                }
            }catch{
                print("Error in get json dsata \(error)")
            }
        }.resume()
    }

    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    return pageQuery * items.data.count
        return items.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : itemsOfCategoryCELL = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! itemsOfCategoryCELL
        
        cell.titlePost.text = items.data[indexPath.row].postTitle
        return cell
    }
}
