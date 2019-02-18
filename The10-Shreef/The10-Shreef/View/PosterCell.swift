//
//  PosterCell.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/13/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import CoreData
import YoutubeKit

class PosterCell: UICollectionViewCell {
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var overView: UITextView!
    @IBOutlet weak var trailerButton: UIButton!
    @IBOutlet weak var imdbLabel: UILabel!
    @IBOutlet weak var additionalLabel: UILabel!
    @IBOutlet weak var additionalImage: UIImageView!
    @IBOutlet weak var imdbImage: UIImageView!

    var movieInfo = Movie()
    let interactor = Interactor()

    override func awakeFromNib() {
        super.awakeFromNib()
        self.posterImage.layer.shadowColor = UIColor.white.cgColor
        self.posterImage.layer.shadowRadius = 5
        self.clipsToBounds = true
        trailerButton.addTarget(self, action: #selector(playTrailer), for: .touchUpInside)
    }

    @objc func playTrailer() {
        let tab = TabBarPresenter.mainViewController
        let vc = TrailerVC(movie: movieInfo)
        tab.modalPresentationStyle = .overCurrentContext
        tab.present(PopoverVC(viewController: vc), animated: true, completion: nil)
    }

    func configure(with movie: Movie) {
        movieInfo = movie
        interactor.fetchPoster(posterPath: movie.posterPath) { (image) in
            if let image = image {
                self.posterImage.image = image
            }
        }
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .justified
        paragraphStyle.hyphenationFactor = 1.0
        let font = UIFont.mainItemFont()
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .paragraphStyle: paragraphStyle,
            .foregroundColor : UIColor.white
        ]
        let attributedText = NSAttributedString(string: movie.overView, attributes: attributes)
        overView.attributedText = attributedText
        self.overView.scrollRangeToVisible(NSMakeRange(0,1))
        if movie.imdb.imdbScore == "N/A" || movie.imdb.imdbScore == "" {
            imdbLabel.text = ""
            imdbImage.image = nil
        }
        else {
            imdbLabel.text = movie.imdb.imdbScore + "/10"
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
            additionalLabel.text = ""
            additionalImage.image = nil
        }
    }
}
