//
//  ViewController.swift
//  WindConditionsApp
//
//  Created by Jamil Nawaz on 06/08/2020.
//  Copyright © 2020 Jamil Nawaz. All rights reserved.
//

import UIKit
import SVProgressHUD

extension UIViewController {
    func showLoadingIndicatorView() {
        SVProgressHUD.show()
    }

    func hideLoadingIndicatorView() {
        SVProgressHUD.dismiss()
    }
}

