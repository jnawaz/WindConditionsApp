//
//  ViewController+Utils.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 06/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit

extension UIViewController {
    func showLoadingIndicatorView() {
        /* Haven't implemented spinner based on loading screen performance issue - detailed in cover note */
    }

    func hideLoadingIndicatorView() {
        /* Haven't implemented spinner based on loading screen performance issue - detailed in cover note */
    }
}

//MARK: - Alerts
extension UIViewController {
    func presentAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
}

