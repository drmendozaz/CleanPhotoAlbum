//
//  ThumbnailCell.swift
//  CleanPhotoAlbum
//
//  Created by Daniel Mendoza Zamores on 19/10/20.
//  Copyright © 2020 Daniel Inc. All rights reserved.
//

import UIKit

class ThumbnailCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override var isHighlighted: Bool {
        didSet {
            if self.isHighlighted {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 0.98, y: 0.98)
                })
            } else {
                UIView.animate(
                    withDuration: 0.1,
                    animations: {
                        self.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                })
            }
        }
    }
}
