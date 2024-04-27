//
//  ActivityIndicatorClass.swift
//  Task
//
//  Created by Suraj Bhujbal on 26/04/24.
//

import Foundation
import UIKit



class ActivityIndicatorClass{
    
    private var activityIndicator: UIActivityIndicatorView?

     init() {}
    
     func showActivityIndicator() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else {
                return
            }
            let activityIndicator = UIActivityIndicatorView(style: .large)
            activityIndicator.center = keyWindow.center
            activityIndicator.color = .systemBlue
            activityIndicator.startAnimating()
            activityIndicator.tag = 999
            keyWindow.addSubview(activityIndicator)
            self.activityIndicator = activityIndicator
        }
    }
     func hideActivityIndicator() {
        DispatchQueue.main.async {
            guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }),
                  let activityIndicator = keyWindow.viewWithTag(999) as? UIActivityIndicatorView else {
                return
            }
            activityIndicator.stopAnimating()
            activityIndicator.removeFromSuperview()
        }
    }
}
