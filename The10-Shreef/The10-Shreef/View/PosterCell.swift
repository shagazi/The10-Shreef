//
//  PosterCell.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/13/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import CoreData

class PosterCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overView: UITextView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var additionalImage: UIImageView!
    @IBOutlet weak var imdbImage: UIImageView!

    let trailerID = ""
    let interactor = Interactor()

    override func awakeFromNib() {
        super.awakeFromNib()
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

    func configureNowPlaying(with movie: Movie) {
        interactor.fetchPoster(posterPath: movie.posterPath) { (image) in
            if let image = image {
                self.posterImage.image = image
            }
        }
        overView.text = movie.overView
        self.overView.scrollRangeToVisible(NSMakeRange(0,1))
        if movie.imdb.imdbScore == "N/A" || movie.imdb.imdbScore == "" {
            setEmptyLabel()
        }
        else {
            imdbLabel.text = movie.imdb.imdbScore
            imdbImage.image = #imageLiteral(resourceName: "icons8-imdb-48")
        }
        additionalLabel.text = movie.imdb.rottenTomatoes
        let rtScore = movie.imdb.rottenTomatoes.replacingOccurrences(of: "%", with: "")
        if let rtScore = Int(rtScore) {
            if rtScore >= 60 {
                additionalImage.image = #imageLiteral(resourceName: "icons8-tomato-48")
                additionalLabel.textColor = UIColor.tomatoColor
            }
            else {
                additionalImage.image = #imageLiteral(resourceName: "icons8-rotten-tomatoes-48")
                additionalLabel.textColor = UIColor.rottenColor
            }
        }
        if movie.imdb.rottenTomatoes == "" {
            setEmptyLabel()
        }
    }

    func setEmptyLabel() {
        imdbLabel.text = ""
        imdbImage.image = nil
        additionalLabel.text = ""
        additionalImage.image = nil
    }
}

extension PosterCell: UIViewControllerTransitioningDelegate {

    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        let vc = PresentationController(presentedViewController: presented, presenting: presenting)
        return vc
    }
}
