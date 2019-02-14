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
        self.isPagingEnabled = true
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ParallaxAttributesAnimator(speed: 2)
        self.collectionViewLayout = layout
        layout.itemSize = CGSize(width: superview?.frame.width ?? 300, height: superview?.frame.height ?? 450)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.collectionView?.showsHorizontalScrollIndicator = false
    }
}
