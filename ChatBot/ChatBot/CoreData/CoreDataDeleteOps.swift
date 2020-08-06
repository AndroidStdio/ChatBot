//
//  CoreDataDeleteOps.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/6/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import Foundation
import CoreData

class CoreDataDeleteOps {
    let coreDataManager = CoreDataManager.shared
    static let shared = CoreDataDeleteOps()

    func deleteOfflineMessages() {
        let fetchRequest: NSFetchRequest<OfflineMessage> = OfflineMessage.fetchRequest()
        let objects = coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: coreDataManager.mainContext)
        if !objects.isEmpty {
            coreDataManager.batchDelete(objects: objects, context: coreDataManager.mainContext)
        }
    }
}
