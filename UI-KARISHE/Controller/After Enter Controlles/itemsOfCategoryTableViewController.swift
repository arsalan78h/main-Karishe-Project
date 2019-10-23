//
//  itemsOfCategoryTableViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 9/18/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class itemsOfCategoryTableViewController: UITableViewController {
    
    
    var items = MobileDevJSON(data: [mobileDevDatum](), paginate: "default0", msg: "default0", success: false, maxNumPages: 0, total: "default0")
    var privateList = MobileDevJSON(data: [mobileDevDatum](), paginate: "default0", msg: "default0", success: false, maxNumPages: 0, total: "default0")
    
    var slugpass : String = ""
    var cateNamePass = ""
    var pageQuery = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ItemTableViewCell.self)
        getDataForItemsOfCategories(withPage: 1)
        
        tableView.separatorStyle = .none
        navigationItem.title = cateNamePass
        
        print(slugpass)
        
    }
    override func viewWillAppear(_ animated: Bool) {
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableView.automaticDimension
    }
    
    func loadItems(cell : ItemTableViewCell , index  : Int) {
        
        var listOfSkills : String = "مهارت: "
        var sk = 0
        
        while sk < privateList.data[index].skill.count {
            listOfSkills = listOfSkills + " | " + privateList.data[index].skill[sk].name
            sk = sk + 1
        }
        
        cell.postTitleLabel.text = privateList.data[index].postTitle
        cell.postDateLabel.text = privateList.data[index].postDate
        cell.skillsPostLabel.text = listOfSkills
        cell.totalBidsLabel.text = privateList.data[index].textTotalBid
        cell.budgetBidLabel.text = privateList.data[index].budget
    }
    
    func getDataForItemsOfCategories(withPage : Int){
        let url = URL(string: "https://www.karishe.com/wp-admin/admin-ajax.php?query%5Bpost_type%5D=project&query%5Bpost_status%5D=publish&query%5Borderby%5D=et_budget&query%5Bplace_category%5D=&query%5Bmeta_key%5D=&query%5Bmeta_value%5D=&query%5Blocation%5D=&query%5Bshowposts%5D=&query%5Border%5D=DESC&query%5Bis_archive_project%5D=true&query%5Bpaginate%5D=page&page=\(withPage)&paged=1&paginate=page&action=ae-fetch-projects&query%5Bproject_category%5D=\(slugpass)&query%5Bs%5D")
        
        
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
      //  showActivityIndicator("Loading", haveBlurEffect: false)
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do { if error == nil{
                self.items = try JSONDecoder().decode(MobileDevJSON.self, from: data!)
                
                self.privateList.data.append(contentsOf: self.items.data)
                
                
                
                //                for _ in self.items.data{  //MobileDev
                DispatchQueue.main.async {
                 //   self.hideActivityIndicator()
                    self.tableView.reloadData()
                    self.hideActivityIndicator()
                }
                //                    }
                print("-------------------------------")
                for obj in self.items.data {
                    print("name of post : \(obj.postTitle)")
                }
                
                print("-------------------------------")
          //      let string1 = String(data: data!, encoding: String.Encoding.utf8) ?? "Data could not be printed"
                
                }
            }catch{
                print("Error in get json dsata \(error)")
                //for debug total_Bids now.............................../////
                self.getDataForItemsOfCategories(withPage: withPage + 1)
            }
        }.resume()
    }
    
    // MARK: - Table view data source

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    //    return pageQuery * items.data.count
//        return items.data.count
        return privateList.data.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

//        let cell : itemsOfCategoryCELL = tableView.dequeueReusableCell(withIdentifier: "itemsCell") as! itemsOfCategoryCELL
//
//        cell.titlePost.text = privateList.data[indexPath.row].postTitle
//        if indexPath.row == privateList.data.count - 1 {
//            showActivityIndicator("loading", haveBlurEffect: false)
//            if pageQuery < items.maxNumPages {
//                print("page inside = \(pageQuery - 1)")
//            pageQuery = pageQuery + 1
//            print("--------------------")
//                print("maxPage = \(items.maxNumPages)")
//                print("totalOBJ  = \(items.total)")
//                print(privateList.data.count)
//            print("--------------------")
//            getDataForItemsOfCategories(withPage: pageQuery)
//            }
//
//    }
//        return cell
        
        
    let cell = tableView.dequeueReuseableCell(forIndexPath: indexPath) as ItemTableViewCell
        loadItems(cell: cell, index: indexPath.row)
        if indexPath.row == privateList.data.count - 1 {
                    if pageQuery < items.maxNumPages {
                        print("page inside = \(pageQuery)")
                    pageQuery = pageQuery + 1
                    print("--------------------")
                        print("maxPage = \(items.maxNumPages)")
                        print("totalOBJ  = \(items.total)")
                        print(privateList.data.count)
                    print("--------------------")
                    getDataForItemsOfCategories(withPage: pageQuery)
                    }
        }
        
    return cell
    
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return tableView.frame.height / 4
      }
      
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Did select row at: \(indexPath)")
      }
    

    
}








//extension UITableViewController: UITableViewDelegate {
//  func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//    return tableView.frame.height / 4
//  }
//
//  func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//    print("Did select row at: \(indexPath)")
//  }
//}
