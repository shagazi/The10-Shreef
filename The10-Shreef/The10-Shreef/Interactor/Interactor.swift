//
//  Interactor.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import TMDBSwift

class Interactor  {

    func fetchNowPlaying(completionHandler: @escaping((ClientReturn?, [MovieMDB]?) -> Void)) {
        MovieMDB.nowplaying(page: 1) { (client, movies) in
            completionHandler(client, movies)
        }
    }

    func fetchUpcoming(completionHandler: @escaping((ClientReturn?, [MovieMDB]?) -> Void)) {
        MovieMDB.upcoming(page: 1) { (client, movies) in
            completionHandler(client, movies)
        }
    }

    func fetchMovieData(movieID: Int, append_to: [String], completionHandler: @escaping ((ClientReturn?, MovieDetailedMDB?, JSON?) -> Void)) {
        MovieMDB.movieAppendTo(movieID: movieID, append_to: append_to) { (client, movieDetails, json) in
            completionHandler(client, movieDetails, json)
        }
    }

    func fetchReviews(movieID: Int, completionHandler: @escaping((ClientReturn?, [MovieReviewsMDB]?) -> Void)){
        MovieMDB.reviews(movieID: movieID, page: 1) { (client, movieReviews) in
            completionHandler(client, movieReviews)
        }
    }

    func fetchTrailer(movieID: Int, completionHandler: @escaping((ClientReturn?, [VideosMDB]?) -> Void)) {
        MovieMDB.videos(movieID: movieID) { (client, videoInfo) in
            completionHandler(client, videoInfo)
        }
    }

    


//
//func getVideos() {
//    MovieMDB.videos(movieID: self.nowPlaying[0].id) { (client, videos) in
//        if let videos = videos {
//            for i in videos {
//                //                    print(i.site)
//                //                    print(i.name)
//                print(i)
//
//            }
//        }
//    }
//}

}
