//
//  TrailerVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import YoutubeKit
import CoreData

class TrailerVC: UIViewController, YTSwiftyPlayerDelegate {
    @IBOutlet weak var trailerView: UIView!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var directedLabel: UILabel!
    @IBOutlet weak var dateReleaseLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!

    var player: YTSwiftyPlayer!
    var movieInfo: Movie!
    let interactor = Interactor()
    var genres: [String] = []

    init(movie: Movie) {
        movieInfo = movie
        super.init(nibName: "TrailerVC", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ratedLabel.text = "Rated " + movieInfo.imdb.rated
        ratedLabel.font = UIFont(name: "Arial", size: 14)
        ratedLabel.sizeToFit()

        directedLabel.text = "Starring: " + movieInfo.imdb.actors
        directedLabel.sizeToFit()
        directedLabel.font = UIFont.mainItemFont()

        genreLabel.text = "Genres: " + movieInfo.imdb.genre
        genreLabel.sizeToFit()
        genreLabel.font = UIFont.mainItemFont()

        if let releaseDate = dateSanitize(date: movieInfo.releaseDate) {
            dateReleaseLabel.text = releaseDate
            dateReleaseLabel.font = UIFont(name: "Arial", size: 14)
            dateReleaseLabel.textColor = UIColor.white
            dateReleaseLabel.textAlignment = .center
            dateReleaseLabel.sizeToFit()
        }

        runTimeLabel.text = movieInfo.imdb.runtime
        runTimeLabel.font = UIFont(name: "Arial", size: 14)
        runTimeLabel.sizeToFit()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 0, width: trailerView.frame.width, height: trailerView.frame.height), playerVars: [.videoID(movieInfo.trailer.path)])
        trailerView.addSubview(player)
        trailerView = player
        player.delegate = self
        player.loadPlayer()
    }

    func dateSanitize(date: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.calendar = Calendar(identifier: .iso8601)
        dateFormatter.dateFormat = "yyyy-MM-dd"
        let newFormat = DateFormatter()
        newFormat.dateFormat = "MMMM dd, yyyy"
        if let date = dateFormatter.date(from: date) {
            return newFormat.string(from: date)
        } else {
            return nil
        }
    }

}
