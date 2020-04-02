//
//  Utility.swift
//  cats
//
//  Created by Josaphat Campos Pereira on 01/04/20.
//  Copyright © 2020 Josaphat Campos Pereira. All rights reserved.
//

import Foundation
import UIKit
import SystemConfiguration

class UIHelper{
    static func activityIndicator(view: UIView, title: String) -> UIView {
        var strLabel = UILabel()
        var activityIndicator = UIActivityIndicatorView()
        let effectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        
        let subView: UIView = UIView()
        view.addSubview(subView)
        
        strLabel.removeFromSuperview()
        activityIndicator.removeFromSuperview()
        effectView.removeFromSuperview()
        
        strLabel = UILabel(frame: CGRect(x: 50, y: 0, width: 160, height: 46))
        strLabel.text = title
        strLabel.font = UIFont.systemFont(ofSize: 14, weight: UIFont.Weight.medium)
        strLabel.textColor = UIColor(white: 0.9, alpha: 0.7)
        
        effectView.frame = CGRect(x: view.frame.midX - strLabel.frame.width/2, y: view.frame.midY - strLabel.frame.height/2 , width: 160, height: 46)
        effectView.layer.cornerRadius = 15
        effectView.layer.masksToBounds = true
        
        activityIndicator = UIActivityIndicatorView(style: .white)
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 46, height: 46)
        activityIndicator.startAnimating()
        
        effectView.contentView.addSubview(activityIndicator)
        effectView.contentView.addSubview(strLabel)
        subView.addSubview(effectView)
        
        return subView
    }
    
    static func stopsIndicator(view: UIView){
        view.subviews.forEach({ $0.removeFromSuperview() })
    }
}
