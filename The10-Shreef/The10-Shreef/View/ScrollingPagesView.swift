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
//        self.frame.size = CGSize(width: superview?.frame.width ?? 300, height: 400)
        self.layer.backgroundColor = UIColor.clear.cgColor
        self.isPagingEnabled = true
        let layout = AnimatedCollectionViewLayout()
        layout.animator = ZoomInOutAttributesAnimator(scaleRate: 1)
//        layout.animator = CrossFadeAttributesAnimator()
//        layout.animator = SnapInAttributesAnimator()
//        layout.animator = CubeAttributesAnimator(perspective: -1/200, totalAngle: 200)
//        layout.animator = ParallaxAttributesAnimator(speed: 2)
        self.collectionViewLayout = layout
        layout.itemSize = CGSize(width: superview?.frame.width ?? 200, height: superview?.frame.height ?? 300)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.collectionView?.showsHorizontalScrollIndicator = false
    }
}
