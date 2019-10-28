//
//  UIView+Extensions.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/24/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import UIKit

extension UIView {
    func setupInCenter(of rootView: UIView, offset: CGPoint = CGPoint()) {
        self.translatesAutoresizingMaskIntoConstraints = false
        
        NSLayoutConstraint.activate([
            self.centerXAnchor.constraint(equalTo: rootView.centerXAnchor, constant: offset.x),
            self.centerYAnchor.constraint(equalTo: rootView.centerYAnchor, constant: offset.y)
        ])
    }
}
