//
//  Utils.swift
//  CleanSwiftBankTestSample
//
//  Created by Abhishek D on 16/10/19.
//  Copyright © 2019 Abhishek D. All rights reserved.
//

import Foundation
import UIKit

/**
 This file is use to call custom loading view when you have shows time consuming processeses like networking call.
 
 - Parameters:
    - container: It is a view which block the user interface to interact
    - loadingView: Loading view is a small square view which shows top of a view
    - activityIndicator: It is use to show loading indicator
 */

class Utils {
    var container: UIView = UIView()
    var loadingView: UIView = UIView()
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()

    /**
     Call this function to show customized activity indicator
     
     - Parameters:
     - uiView: It is a view on top of this activity indicator will display
     */
    
    func showActivityIndicator(uiView: UIView) {
        container.frame = uiView.frame
        container.center = uiView.center
        container.tag = 100
        container.backgroundColor = UIColorFromHex(rgbValue: 0xffffff, alpha: 0.3)
        
        loadingView.frame = CGRect(x: 0, y: 0, width: 80, height: 80)
        loadingView.center = uiView.center
        loadingView.backgroundColor = UIColorFromHex(rgbValue: 0x444444, alpha: 0.7)
        loadingView.clipsToBounds = true
        loadingView.layer.cornerRadius = 10
        
        activityIndicator.frame = CGRect(x: 0, y: 0, width: 40, height: 40)
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.whiteLarge
        activityIndicator.center = CGPoint(x: loadingView.frame.size.width / 2, y: loadingView.frame.size.height / 2);
        
        loadingView.addSubview(activityIndicator)
        container.addSubview(loadingView)
        uiView.addSubview(container)
        activityIndicator.startAnimating()
    }
    
    /**
     Call this function to hide customized activity indicator
     
     - Parameters:
     - uiView: Specify the view on which activity indicator is displaying.
     */
    
    func hideActivityIndicator(uiView: UIView) {
        activityIndicator.stopAnimating()
        if let viewWithTag = uiView.viewWithTag(100) {
            viewWithTag.removeFromSuperview()
        }else{
            print("Loading view not removed!")
        }
    }
    
    // Define UIColor from hex value
    func UIColorFromHex(rgbValue:UInt32, alpha:Double=1.0)->UIColor {
        let red = CGFloat((rgbValue & 0xFF0000) >> 16)/256.0
        let green = CGFloat((rgbValue & 0xFF00) >> 8)/256.0
        let blue = CGFloat(rgbValue & 0xFF)/256.0
        return UIColor(red:red, green:green, blue:blue, alpha:CGFloat(alpha))
    }
}
