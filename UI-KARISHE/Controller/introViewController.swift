//
//  ViewController.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 7/20/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//

import UIKit
import SCLAlertView

class introViewController: UIViewController , UICollectionViewDataSource , UICollectionViewDelegate , UICollectionViewDelegateFlowLayout {
    
    @IBOutlet weak var AuthPageCV: UICollectionView!
    @IBOutlet weak var registerButt: UIButton!
    @IBOutlet weak var logInButt: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        AuthPageCV.dataSource = self
        AuthPageCV.delegate = self
        
        setupIntroView()
        
    }
// MARK: - SETUP VIEW/////////////////////////////////////////////////////////////////
    func setupIntroView() {
        
        registerButt.layer.cornerRadius = 20.0
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        if !CheckInternet.Connection(){
            
        _ = SCLAlertView().showError("مشکل در اتصال اینترت", subTitle:"دوباره سعی کنید", closeButtonTitle:"تایید")
        }
    }
    
    // MARK: - COLLECTIONVIEW DELEGATE AND DATASOURCE
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 3    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell : CVAuthPageCustomCell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CVAuthPageCustomCell
        
        cell.imageViewCell.image = UIImage(named: "TestImage" )
        return cell
        
    }
    
    func collectionView(_ collectionView: UICollectionView, layout
        collectionViewLayout: UICollectionViewLayout,
                        minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        
        return 0
    }
    
//    private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
//        return CGSize(width: 10, height: 10)
//    }
}

