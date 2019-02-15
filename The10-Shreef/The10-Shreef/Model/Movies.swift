//
//  Movies.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import TMDBSwift

class Movies: NSObject {
    var id: Int = 0
    var title: String = ""
    var posterPath: String = ""
    var key: String = ""
    var tagline: String = ""
    var genres: [String] = []
    var overView: String = ""

    var movies: [MovieMDB] = []
    var nowPlaying: [Movies] = []

    func fetchNowPlaying(completionHandler: @escaping((ClientReturn?, [MovieMDB]?) -> Void)) {
        MovieMDB.nowplaying(page: 1) { (client, movies) in
            if let movies = movies {
                for i in 0...9 {
                    self.movies.append(movies[i])
                }
            }
            completionHandler(client, movies)
        }
    }

}

