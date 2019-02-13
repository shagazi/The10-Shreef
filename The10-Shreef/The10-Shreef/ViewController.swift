//
//  ViewController.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import TMDBSwift

class ViewController: UIViewController {
    var nowPlaying: [MovieMDB] = []
    var videos: [VideosMDB] = []

    override func viewDidLoad() {
        super.viewDidLoad()
//            self.getNowPlaying()
        self.view.backgroundColor = .red
        self.navigationController?.pushViewController(NowPlayingVC(), animated: true)
//        playVideo()
    }

//    func getNowPlaying(){
//        MovieMDB.nowplaying(page: 1) { (client, movies) in
//            if let movies = movies {
//                self.nowPlaying = movies
//                MovieMDB.videos(movieID: self.nowPlaying[0].id) { (client, videos) in
//                    if let videos = videos {
//                        self.videos = videos
//                    }
//                    let playerView = YTPlayerView()
//                    playerView.load(withVideoId: self.videos[0].key)
//                    self.view.addSubview(playerView)
//                }
//            }
//        }
//    }
//
//    func playVideo() {
//        let playerView = YTPlayerView()
//        playerView.load(withVideoId: self.videos[0].key)
//        self.view.addSubview(playerView)
//    }
}


