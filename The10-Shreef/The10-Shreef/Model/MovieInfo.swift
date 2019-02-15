//
//  MovieInfo.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import CoreData
import Novagraph

@objc (MovieInfo)
class MovieInfo: NSManagedObject, FetchOrCreatable {
    typealias T = MovieInfo
    static var apiName: String = "movieInfo"

    @NSManaged var id: String
    @NSManaged var key: String

    func parse(data: [String : Any]) {
        if let id = data["id"] as? String {
            self.id = id
        }
        if let key = data["key"] as? String {
            self.key = key
        }
    }



}
