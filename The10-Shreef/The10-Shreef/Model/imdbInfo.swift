//
//  imdbRating.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

struct imdbInfo: Codable {
    let Rated       : String?
    let Director    : String?
    let imdbRating  : String?
    let imdbID      : String?
    let Ratings     : [[String : String]]?
}
