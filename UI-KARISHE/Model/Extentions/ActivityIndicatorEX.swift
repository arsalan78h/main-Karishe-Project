//
//  ActivityIndicatorEX.swift
//  UI-KARISHE
//
//  Created by Arsalan Hashemi on 8/25/19.
//  Copyright © 2019 ArSaLaNhashemi. All rights reserved.
//
import UIKit

extension UIViewController {
    func showActivityIndicator(_ title: String , haveBlurEffect : Bool ) {
        
        var activityIndicator = UIActivityIndicatorView()
        var strLabel = UILabel()
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = .systemFont(ofSize: 17, weight: .medium) //14 , medium
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 20
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        
        activityIndicator.tag = 100
        strLabel.tag = 200
        effectView.tag = 300
        
        for subview in view.subviews {
            if subview.tag == 100 {
                print("already added")
                return
            }
        }
        if haveBlurEffect == true {
        let blurEffect = UIBlurEffect(style: UIBlurEffect.Style.dark)
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = view.bounds
        blurEffectView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        blurEffectView.tag = 400
        view.addSubview(blurEffectView)
        }
        
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        view.addSubview(effectView)
    }
    
    func hideActivityIndicator() {
        
        let activityIndicator = view.viewWithTag(100) as? UIActivityIndicatorView
        let strLabel = view.viewWithTag(200) as? UILabel
        let effectView = view.viewWithTag(300) as? UIVisualEffectView
        
        
        activityIndicator?.stopAnimating()
        activityIndicator?.removeFromSuperview()
        strLabel?.removeFromSuperview()
        effectView?.removeFromSuperview()
        
        for subview in view.subviews {
            if subview.tag == 400 {
                print("already added")
                let blurEffectView = view.viewWithTag(400) as? UIVisualEffectView
                blurEffectView?.removeFromSuperview()
            }
        
    }
}
}
