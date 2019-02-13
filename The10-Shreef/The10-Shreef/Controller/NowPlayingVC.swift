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

    var nowPlaying: [MovieMDB] = []
    var videos: [VideosMDB] = []

    override func viewDidLoad() {
        super.viewDidLoad()


        MovieMDB.nowplaying(page: 1) { (client, movies) in
            if let movies = movies {
                self.nowPlaying = movies
                MovieMDB.videos(movieID: self.nowPlaying[0].id) { (client, videos) in
                    if let videos = videos {
                        self.videos = videos
                    }
                    self.video.loadVideoID(self.videos[0].key)

                }
            }
        }

        //
        // Do any additional setup after loading the view.
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
