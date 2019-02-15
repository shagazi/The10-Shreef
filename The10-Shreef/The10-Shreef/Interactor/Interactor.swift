//
//  Interactor.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import TMDBSwift
import CoreData

class Interactor: NSObject {
    func fetchNowPlaying(completionHandler: @escaping((ClientReturn?, [MovieMDB]?) -> Void)) {
        MovieMDB.nowplaying(page: 1) { (client, movies) in
            MovieMDB.movieAppendTo(movieID: movies?[1].id, append_to: ["videos", "reviews"], completion: { (client, movies, json) in
                //Todo: Make movie list
                
            })
            completionHandler(client, movies)
        }
    }

    func fetchImdb(imdbID: String, completionHandler: @escaping ((JSON?, Error?) -> Void)) {
        var components          = URLComponents()
        components.scheme       = "https"
        components.host         = "www.omdbapi.com"
        components.queryItems   = [URLQueryItem(name: "i", value: imdbID),
                                   URLQueryItem(name: "apikey", value: "a3a5bcba")]

        guard let url = components.url else { return }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if error != nil {
                print(error!.localizedDescription)
            }
            guard let data = data else { return }

            do {
                let ratingData = try JSONDecoder().decode(imdbInfo.self, from: data)
                DispatchQueue.main.async {
                    //Todo: parse ratingData
                }
            } catch let error {
                print(error)
            }
        }.resume()
    }

    func fetchUpcoming(completionHandler: @escaping((ClientReturn?, [MovieMDB]?) -> Void)) {
        MovieMDB.upcoming(page: 1) { (client, movies) in
            //Todo: MakeMovie List
            completionHandler(client, movies)
        }
    }
    
    func fetchTrailer(movieID: Int, completionHandler: @escaping((ClientReturn?, [VideosMDB]?) -> Void)) {
        MovieMDB.videos(movieID: movieID) { (client, videoInfo) in
            completionHandler(client, videoInfo)
        }
    }
}
