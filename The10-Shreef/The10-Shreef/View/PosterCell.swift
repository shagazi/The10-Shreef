//
//  PosterCell.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/13/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit

class PosterCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.posterImage.layer.shadowColor = UIColor.gray.cgColor
        self.clipsToBounds = false
        self.layer.borderWidth = 2

    }

    func configure(with posterImage: UIImage) {
        self.posterImage.image = posterImage
    }

}
