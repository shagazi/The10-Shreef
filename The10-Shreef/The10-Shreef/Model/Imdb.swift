//
//  Imdb.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/15/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import CoreData
import TMDBSwift

@objc(Imdb)
class Imdb: NSManagedObject, FetchOrCreate, HasId {
    typealias T = Imdb
    
    @NSManaged var id             : String
    @NSManaged var path           : String
    @NSManaged var rated          : String
    @NSManaged var genre          : String
    @NSManaged var actors         : String
    @NSManaged var runtime        : String
    @NSManaged var director       : String
    @NSManaged var imdbScore      : String
    @NSManaged var metaCritic     : String
    @NSManaged var rottenTomatoes : String
    

    func parse(client: ClientReturn) {
        guard let json = client.json else { return }
        guard let path = json["imdb_id"].rawString() else { return }
        self.path = path
        guard let id = json["id"].rawString() else { return }
        self.id = id
    }

    func parse(imdbInfo: imdbInfo) {
        if let director = imdbInfo.Director {
            self.director = director
        }
        if let rated = imdbInfo.Rated {
            self.rated = rated
        }
        if let imdbScore = imdbInfo.imdbRating {
            self.imdbScore = imdbScore
        }
        if let ratings = imdbInfo.Ratings {
            for type in ratings {
                if type["Source"] == "Rotten Tomatoes" {
                    if let value = type["Value"] {
                        self.rottenTomatoes = value
                    }
                }
                if type["Source"] == "Metacritic" {
                    if let value = type["Value"] {
                        self.metaCritic = value
                    }
                }
            }
        }
        if let actors = imdbInfo.Actors {
            self.actors = actors
        }
        if let genres = imdbInfo.Genre {
            self.genre = genres
        }
        if let runtime = imdbInfo.Runtime {
            self.runtime = runtime
        }
    }
}

