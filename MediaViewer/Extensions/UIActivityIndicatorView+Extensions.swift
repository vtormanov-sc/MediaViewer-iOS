//
//  UIActivityIndicatorView+Extensions.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/22/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import UIKit

extension UIActivityIndicatorView {
    static func setupIndicator(onto rootView: UIView, offset: CGPoint = CGPoint()) -> UIActivityIndicatorView {
        let indicator = UIActivityIndicatorView()
        let indicatorSize: CGFloat = 40
        
        rootView.addSubview(indicator)
        
        indicator.translatesAutoresizingMaskIntoConstraints = false
        
        indicator.setupInCenter(of: rootView, offset: offset)

        NSLayoutConstraint.activate([
            indicator.widthAnchor.constraint(equalToConstant: indicatorSize),
            indicator.heightAnchor.constraint(equalToConstant: indicatorSize)
        ])
        
        indicator.hidesWhenStopped = true
        
        return indicator
    }
}
