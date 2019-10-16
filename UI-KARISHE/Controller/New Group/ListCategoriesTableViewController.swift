//
//  ListCategoriesViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 9/17/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit

class ListCategoriesTableViewController: UITableViewController  {
    
    var categoriesItems = [CategoriesJSON]()

    override func viewDidLoad() {
        super.viewDidLoad()

        getDataForCategories()

    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    func getDataForCategories(){
        let url = URL(string: "http://www.karishe.ir/wp-json/wp/v2/all-terms?term=project_category")
        URLSession.shared.dataTask(with: url!) { (data, response, error) in
            do { if error == nil{
                self.categoriesItems = try JSONDecoder().decode([CategoriesJSON].self, from: data!)
                for _ in self.categoriesItems{
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                }
            }
            }catch{
                print("Error in get json data \(error)")
            }
            }.resume()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoriesItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell : ListCategoriesCELL = tableView.dequeueReusableCell(withIdentifier: "identycell") as! ListCategoriesCELL
        
        loadCategoriesCell(indexPath: indexPath.row, cell: cell, toIndexPath: 20)
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        performSegue(withIdentifier: "goToItems", sender: self)
        
    }
    
    
    
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    
    let vc = segue.destination as! itemsOfCategoryTableViewController
        if let indexPath = tableView.indexPathForSelectedRow {
            vc.cateNamePass = categoriesItems[indexPath.row].name
            vc.slugpass = categoriesItems[indexPath.row].slug
    }
    }
    
    func loadCategoriesCell(indexPath: Int, cell: ListCategoriesCELL, toIndexPath: Int){
        
        loadFieldName(indexPath: indexPath, cell: cell, toIndexPath: toIndexPath)
        loadImage(indexPath: indexPath, cell: cell , toIndexPath : toIndexPath)
    }
    
    func loadFieldName(indexPath : Int , cell : ListCategoriesCELL , toIndexPath : Int) {
        if indexPath < toIndexPath {
            cell.categoryFieldName.text = "\(categoriesItems[indexPath].name)"
        }
    }
    
    func loadImage(indexPath : Int , cell : ListCategoriesCELL , toIndexPath : Int) {
        
        let session = URLSession(configuration: .default)
        if (indexPath < toIndexPath) {
            let URL_IMAGE = URL(string: categoriesItems[indexPath].image! )
            //creating a dataTask
            let getImageFromUrl = session.dataTask(with: URL_IMAGE!) { (data, response, error) in
                //if there is any error
                if let e = error {
                    //displaying the message
                    print("Error Occurred: \(e)")
                    } else {
                        //in case of now error, checking wheather the response is nil or not
                        if (response as? HTTPURLResponse) != nil {
                            //checking if the response contains an image
                            if let imageData = data {
                            //getting the image
                            let image = UIImage(data: imageData)
                                
                            DispatchQueue.main.async {
                                cell.categoryFieldImage.image = image
                            }
                        } else {
                                print("Image file is currupted")
                        }
                    } else {
                        print("No response from server")
                    }
                }
            }
            //starting the download task
            getImageFromUrl.resume()
        }
    }
}
