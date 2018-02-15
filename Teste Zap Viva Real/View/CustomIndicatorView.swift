//
//  CustomIndicatorView.swift
//  Teste Zap Viva Real
//
//  Created by Bruno Rodrigues de Andrade on 13/02/18.
//  Copyright © 2018 Bruno Rodrigues de Andrade. All rights reserved.
//

import UIKit
import NVActivityIndicatorView


extension UICollectionViewController {
    static func displaySpinner(onView : UIView) -> UIView {
        let spinnerView = UIView.init(frame: onView.bounds)
        spinnerView.alpha = 0.5
        spinnerView.backgroundColor = UIColor.init(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        let activityFrame = CGRect(x: onView.frame.size.width/3, y: onView.frame.size.height/3, width: onView.frame.size.width/2, height: onView.frame.size.height/2)
//        activityFrame.origin = onView.center
        let activityIndicatorView = NVActivityIndicatorView(frame: activityFrame, type: .pacman, color: UIColor.yellow, padding: nil)
        activityIndicatorView.startAnimating()

        DispatchQueue.main.async {
            spinnerView.addSubview(activityIndicatorView)
            onView.addSubview(spinnerView)
        }
        
        return spinnerView
    }
    
    static func removeSpinner(_ spinner :UIView) {
        DispatchQueue.main.async {
            spinner.removeFromSuperview()
        }
    }
}

