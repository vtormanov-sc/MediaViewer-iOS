//
//  PostListTableViewCell.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/22/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import UIKit
import Kingfisher

class PostListTableViewCell: UITableViewCell {
    @IBOutlet weak var previewImageView: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        previewImageView.image = nil
    }
    
    func updateImage(withUrl url: URL) {
        previewImageView.kf.indicatorType = .activity
        previewImageView.kf.setImage(with: url)
    }
}
