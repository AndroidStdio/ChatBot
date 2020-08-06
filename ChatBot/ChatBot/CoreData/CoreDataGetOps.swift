//
//  CoreDataGetOps.swift
//  CoreDataPrep
//
//  Created by MCS on 12/3/19.
//  Copyright © 2019 MCS. All rights reserved.
//

import Foundation
import CoreData
import UIKit

class CoreDataGetOps {
    private let coreDataManager = CoreDataManager.shared
    private let context = CoreDataManager.shared.mainContext
    static let shared = CoreDataGetOps()
    
    private init() {}
    
    func getAllMessages() -> [MessageRecord] {
        let fetchRequest: NSFetchRequest<MessageRecord> = MessageRecord.fetchRequest()
        return  coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context).sorted(by: {
            $0.date?.compare($1.date ?? Date.distantFuture) == .orderedAscending
        })
    }
}
