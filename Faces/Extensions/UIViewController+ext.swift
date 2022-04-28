//
//  UIViewController+ext.swift
//  Faces
//
//  Created by Brandon Rodriguez on 3/26/22.
//

import UIKit

extension UIViewController {
    
    func presentFacesAlertOnMainThread(title: String, message: String, buttonTitle: String) {
        
        DispatchQueue.main.async {
            
            let alertVC = FacesAlertVC(title: title, message: message, buttonTitle: buttonTitle)
            alertVC.modalPresentationStyle = .overFullScreen
            alertVC.modalTransitionStyle = .crossDissolve
            self.present(alertVC, animated: true)
            
        }
        
    }
    
}
