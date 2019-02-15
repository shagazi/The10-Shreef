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
    @IBOutlet weak var synopsisView: UITextView!
    @IBOutlet weak var trailerButton: UIButton!

    var trailerID: String = ""

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.posterImage.layer.shadowColor = UIColor.white.cgColor
        self.posterImage.layer.shadowRadius = 5
        trailerButton.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
    }

    @objc func playTrailer() {
        let tab = TabBarPresenter.mainViewController
        let vc = TrailerVC(trailerID: trailerID)
        tab.present(vc, animated: true, completion: nil)
        tab.modalPresentationStyle = .overCurrentContext
        tab.transitioningDelegate = self
//        tab.present(NowPlayingVC(), animated: true, completion: nil)
    }

    func configure(with posterImage: UIImage) {
        self.posterImage.image = posterImage
    }

}

extension PosterCell: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = PresentationController(presentedViewController: presented, presenting: presenting)
        return vc
    }
}
