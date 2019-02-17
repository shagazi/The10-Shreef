//
//  Trailer.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/15/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import CoreData
import TMDBSwift

@objc(Trailer)
class Trailer: NSManagedObject, FetchOrCreate, HasId {
    typealias T = Trailer
    
    @NSManaged var id: String
    @NSManaged var path: String

    func parse(client: ClientReturn, results: [VideosMDB]) {
        guard let json = client.json else { return }
        guard let id = json["id"].rawString() else { return }
        self.id = id
        for result in results {
            if result.type == "Trailer" {
                path = result.key
                break
            }
        }
    }
}
