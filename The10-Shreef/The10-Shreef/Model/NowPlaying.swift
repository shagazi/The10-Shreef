////
////  NowPlaying.swift
////  The10-Shreef
////
////  Created by Shreef Hagazi  on 2/14/19.
////  Copyright © 2019 Shreef Hagazi . All rights reserved.
////
//
//import UIKit
//import CoreData
//import TMDBSwift
//import Foundation
//import Novagraph
//
//@objc(NowPlaying)
//class NowPlaying: NSManagedObject, FetchOrCreatable {
//
//    func parse(data: [String : Any]) {
//    }
//
//    typealias T = NowPlaying
//    static var apiName = "nowplaying"
//
//    @NSManaged var id: Int
//    @NSManaged var title: String
//    @NSManaged var posterPath: String
//    @NSManaged var voteRating: Double
//
//    @NSManaged var movieInfo: MovieInfo
//
//    func parseMovie(movie: MovieMDB) {
//        if let id = movie.id {
//            self.id = id
//        }
//        if let title = movie.title {
//            self.title = title
//        }
//        if let posterPath = movie.title {
//            self.posterPath = posterPath
//        }
//        if let voteRating = movie.vote_average {
//            self.voteRating = voteRating
//        }
//    }
//}
