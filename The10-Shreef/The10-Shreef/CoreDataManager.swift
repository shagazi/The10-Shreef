//
//  CoreDataManager.swift
//  The10-Shreef
//
//  Created by Shreef Hagazi  on 2/14/19.
//  Copyright © 2019 Shreef Hagazi . All rights reserved.
//

import UIKit
import CoreData

class CoreDataManager: NSObject {
    public var context: NSManagedObjectContext!
    public static let shared: CoreDataManager = CoreDataManager()
    public static var containerName: String!

    public class func setUpCoreDataStack(retry: Bool = false) {
        let container = NSPersistentContainer(name: self.containerName)
        container.loadPersistentStores { (_, error) in
            guard error == nil else {
                if retry {
                    self.deleteStore()
                    self.setUpCoreDataStack(retry: false)
                } else {
                    NSLog("Failed to load core data stack!")
                }
                return
            }
            shared.context = container.viewContext
            NSLog("Loaded store!")
        }
    }


    class func deleteStore() {
        var url = NSPersistentContainer.defaultDirectoryURL()
        url.appendPathComponent(self.containerName)
        url.appendPathExtension("sqlite")
        try? FileManager.default.removeItem(at: url)
    }

}
