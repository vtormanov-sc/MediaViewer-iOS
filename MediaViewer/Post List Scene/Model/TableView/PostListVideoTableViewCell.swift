//
//  PostListVideoTableViewCell.swift
//  MediaViewer
//
//  Created by Gleb Shevchenko on 10/21/19.
//  Copyright © 2019 Gleb Shevchenko. All rights reserved.
//

import UIKit

class PostListVideoTableViewCell: PostListTableViewCell {
    @IBOutlet weak var playIcon: UIImageView!
    
    override func prepareForReuse() {
        super.prepareForReuse()
        playIcon.isHidden = true
    }
    
    override func updateImage(withUrl url: URL) {
        previewImageView.kf.indicatorType = .activity
        previewImageView.kf.setImage(with: url) { result in
            switch result {
            case .success:
                self.playIcon.isHidden = false
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}
