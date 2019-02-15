//
//  UpComing.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import CoreData

@objc(UpComing)
class UpComing: NSManagedObject {
    @NSManaged var id          : Int
    @NSManaged var title       : String
    @NSManaged var posterPath  : String
    @NSManaged var trailerPath : String
    @NSManaged var Rated       : String?
    @NSManaged var Director    : String?
    @NSManaged var imdbRating  : String?
    @NSManaged var imdbID      : String?
    @NSManaged var Ratings     : [[String : String]]?
}
