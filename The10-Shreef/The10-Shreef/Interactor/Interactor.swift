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
            let movies = movies
            completionHandler(client, movies)
        }
    }

    func fetchUpcoming(completionHandler: @escaping((ClientReturn?, [MovieMDB]?) -> Void)) {
        MovieMDB.upcoming(page: 1) { (client, movies) in
            completionHandler(client, movies)
        }
    }

    func fetchTrailer(movieID: Int, completionHandler: @escaping((ClientReturn?, [VideosMDB]?) -> Void)) {
        MovieMDB.videos(movieID: movieID) { (client, videoInfo) in
            completionHandler(client, videoInfo)
        }
    }

    func fetchImdb(imdbID: String, completionHandler: @escaping ((imdbInfo?, Error?) -> Void)) {
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
                completionHandler(ratingData, error)
            } catch let error {
                print(error)
            }
        }.resume()
    }

    func fetchPoster(posterPath: String, completionHandler: @escaping ((UIImage?) -> Void)) {
            var url = URL(string: "https://image.tmdb.org/t/p/w500")!
            url.appendPathComponent(posterPath)
            let data = try? Data(contentsOf: url)
            if let imageData = data {
                let image = UIImage(data: imageData)
                completionHandler(image)
        }
    }

}
