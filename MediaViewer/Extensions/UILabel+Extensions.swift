//
//  UILabel+Extensions.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/24/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import Foundation
import UIKit

extension UILabel {
    static func setupErrorLabel(onto rootView: UIView, text: String, offset: CGPoint = CGPoint()) -> UILabel {
        let errorLabel = UILabel()
        errorLabel.numberOfLines = 0
        errorLabel.text = text
        
        rootView.addSubview(errorLabel)
        errorLabel.setupInCenter(of: rootView, offset: offset)
        
        NSLayoutConstraint.activate([
            errorLabel.widthAnchor.constraint(equalTo: rootView.widthAnchor, multiplier: 0.5)
        ])
        
        return errorLabel
    }
}
