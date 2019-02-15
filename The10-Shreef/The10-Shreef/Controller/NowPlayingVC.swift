//
//  NowPlayingVC.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import TMDBSwift
import YouTubePlayer
import AnimatedCollectionViewLayout

class NowPlayingVC: UIViewController {
//    @IBOutlet weak var video:           YouTubePlayerView!
    @IBOutlet weak var collectionView:  ScrollingPagesView!
//    @IBOutlet weak var reviewView:      UITextView!

    var nowPlayingInfo: VideosMDB?
    var nowPlaying: [MovieMDB]  = []
    var movies: [NowPlaying] = [] //fetch movies
    let interactor = Interactor()
    var reuseIdentifier = "poster"
    var youTubeId = String()

    //    var nowplaying = NowPlaying.createNew()

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }

    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nil, bundle: nil)
        self.title = "In Theaters"
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.black

        self.collectionView.dataSource  = self
        self.collectionView.delegate    = self

        let nib = UINib(nibName: "PosterCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

        
        MovieMDB.nowplaying(page: 1) { (client, movies) in
            guard let movies = movies else { return }
            for i in 0...9 {
                self.nowPlaying.append(movies[i])
                MovieMDB.videos(movieID: movies[i].id, completion: { (client, videos) in
                    guard let videos = videos else { return }
                    for video in videos {
                        if video.type == "Trailer" {
                            self.nowPlayingInfo = video
                            break
                        }
                    }
                })
            }
            self.collectionView.reloadData()
        }

//        interactor.createNowPlaying(movies: nowPlaying, trailers: <#T##VideosMDB#>, imdb: <#T##imdbInfo#>)
//    }

}

extension NowPlayingVC: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if self.nowPlaying.count > 10 {
            return 10
        }
        else {
            return self.nowPlaying.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = self.collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! PosterCell
        let movie = movies[indexPath.row]
        interactor.fetchPoster(posterPath: movie.posterPath) { (image) in
            if let image = image {
                cell.posterImage.image = image
            }
        }
        MovieMDB.videos(movieID: movie.id, completion: { (_, videos) in
            guard let videos = videos else { return }
            for video in videos {
                if video.type == "Trailer" {
                    self.nowPlayingInfo = video

                    break
                }
            }
        })
        cell.synopsisView.text = movie.overView
        cell.clipsToBounds = false
        return cell

    }
}

