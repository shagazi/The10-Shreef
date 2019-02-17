//
//  ScrollingPagesView.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/13/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import AnimatedCollectionViewLayout

class ScrollingPagesView: UICollectionView {
    override func awakeFromNib() {
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.isPagingEnabled = true
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ZoomInOutAttributesAnimator(scaleRate: 1)
        self.collectionViewLayout = layout
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.collectionView?.showsHorizontalScrollIndicator = false
    }

}
