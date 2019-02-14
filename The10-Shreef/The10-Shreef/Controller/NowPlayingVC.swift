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

class NowPlayingVC: UIViewController {
    @IBOutlet weak var video: YouTubePlayerView!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var reviewView: UITextView!

    var nowPlaying: [MovieMDB] = []
    var videos: [VideosMDB] = []
    var reuseIdentifier = "poster"
    let interactor = Interactor()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        let nib = UINib(nibName: "PosterCell", bundle: nil)
        self.collectionView.register(nib, forCellWithReuseIdentifier: reuseIdentifier)

    }


    func fetchMovies(completionHandler: @escaping ((ClientReturn?, [MovieMDB]?) -> Void)){
        interactor.fetchNowPlaying { (client, movies) in
            if let movies = movies {
                for i in 0...9 {
                    self.nowPlaying.append(movies[i])
                }
            }
            completionHandler(client, movies)
        }
    }

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
//        let title = nowPlaying[indexPath.row].title
        //        cell.configure(with: UIImage
        return cell

    }
}
