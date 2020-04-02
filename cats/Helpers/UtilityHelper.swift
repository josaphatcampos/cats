//
//  UtilityHelper.swift
//  cats
//
//  Created by Josaphat Campos Pereira on 01/04/20.
//  Copyright © 2020 Josaphat Campos Pereira. All rights reserved.
//

import Foundation
import Reachability

class UtilityHelper {
    class func isNetworkAvailable() -> Bool {
        
        let reachability = Reachability()!
        
        if reachability.connection != .none {
            return true
        }
        else
        {
            return false
        }
        
    }
    
    class func isIphone() -> Bool{
        enum UIUserInterfaceIdiom : Int {
            case unspecified
            case phone
            case pad
        }
        
        UIDevice.current.userInterfaceIdiom == .pad
        UIDevice.current.userInterfaceIdiom == .phone
        UIDevice.current.userInterfaceIdiom == .unspecified
        
        switch UIDevice.current.userInterfaceIdiom {
            case .phone:
                return true
            case .pad:
                return false
            case .tv:
                return false
            case .carPlay:
                return true
            @unknown default:
                return true
            }
    }
}
