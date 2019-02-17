//
//  TrailerVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import YoutubeKit

class TrailerVC: UIViewController, YTSwiftyPlayerDelegate {
    @IBOutlet weak var trailerView: UIView!
    @IBOutlet weak var ratedLabel: UILabel!
    @IBOutlet weak var directedLabel: UILabel!
    @IBOutlet weak var runTimeLabel: UILabel!
    var player: YTSwiftyPlayer!
    var trailerID: String = ""
    let movieInfo: Movie

    init(movie: Movie) {
        self.trailerID = movie.trailer.path
        movieInfo = movie
        super.init(nibName: "TrailerVC", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        ratedLabel.text = movieInfo.imdb.rated
        directedLabel.text = movieInfo.imdb.director
        directedLabel.sizeToFit()
    }

    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        player = YTSwiftyPlayer(frame: CGRect(x: 0, y: 0, width: trailerView.frame.width, height: trailerView.frame.height), playerVars: [.videoID(movieInfo.trailer.path)])
        trailerView.addSubview(player)
        trailerView = player
        player.delegate = self
        player.loadPlayer()
        
    }


    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
