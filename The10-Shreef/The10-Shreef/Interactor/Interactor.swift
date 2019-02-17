//
//  Interactor.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/12/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import TMDBSwift
import CoreData

protocol FetchOrCreate: class, HasId {
    associatedtype T: NSManagedObject, HasId
}

protocol HasId {
    var id: String { get set }
}

extension FetchOrCreate {
//    static func fetchOrCreate(with ID: String) -> T {
//        if let object = fetch(with: ID) {
//            return object
//        }
//        else {
//            var object = createNew()
//            object.id = ID
//            return object
//        }
//    }

    static func createNew() -> T {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let className = String(describing: type(of: self)).split(separator:".").first ?? ""
        let newT = NSEntityDescription.insertNewObject(forEntityName: String(className), into: context) as! T
        return newT
    }

    static func fetchObjects(with key: String, with value: String) -> [T] {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let className = String(describing: type(of: self)).split(separator:".").first ?? ""
        let request = NSFetchRequest<T>(entityName: String(className))
        request.predicate = NSPredicate(format: "\(key) == %@", value)
        let fetchedObjects = try! context.fetch(request)
        return fetchedObjects
    }

    static func fetch(with ID: String) -> T? {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let className = String(describing: type(of: self)).split(separator:".").first ?? ""
        let request = NSFetchRequest<T>(entityName: String(className))
        request.predicate = NSPredicate(format: "id == %@", ID)
        let fetchedObjects = try! context.fetch(request)
        if let first = fetchedObjects.first {
            return first
        }
        return nil
    }

}

class Interactor: NSObject {
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
