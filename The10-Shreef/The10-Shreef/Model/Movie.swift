//
//  NowPlaying.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import CoreData
import TMDBSwift

@objc(Movie)
class Movie: NSManagedObject, FetchOrCreate, HasId {
    typealias T = Movie

    @NSManaged var id          : String
    @NSManaged var title       : String
    @NSManaged var posterPath  : String
    @NSManaged var overView    : String
    @NSManaged var type        : String

    @NSManaged var trailer     : Trailer
    @NSManaged var imdb        : Imdb

    func parse(data: MovieMDB){
        self.id = String(data.id)
        if let title = data.title {
            self.title = title
        }
        if let posterPath = data.poster_path {
            self.posterPath = posterPath
        }
        if let overView = data.overview {
            self.overView = overView
        }
    }
}
