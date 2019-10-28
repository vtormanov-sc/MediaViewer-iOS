//
//  UIViewController+Extensions.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/24/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIViewController {
    func presentNetworkErrorAlert(withDescription errorDescription: String, dissmissOnOk: Bool = false) {
        let alertController = UIAlertController(title: "Network error", message: errorDescription, preferredStyle: .alert)
        if dissmissOnOk {
            let okDismissAction = UIAlertAction(title: "OK", style: .default) { _ in
                self.dismiss(animated: true)
            }
            
            alertController.addAction(okDismissAction)
        } else {
            let okAction = UIAlertAction(title: "OK", style: .default)
            alertController.addAction(okAction)
        }
        
        
        present(alertController, animated: true)
    }
}
