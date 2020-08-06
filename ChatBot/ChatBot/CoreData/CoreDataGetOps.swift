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
    
    func getAllMessages(chatId: Int) -> [MessageRecord] {
        let fetchRequest: NSFetchRequest<MessageRecord> = MessageRecord.fetchRequest()
        return  coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context).filter {$0.chatId == Int32(chatId)}
            .sorted(by: {
            $0.date?.compare($1.date ?? Date.distantFuture) == .orderedAscending
        })
    }
    
    func fetchChatList() -> [ChatList] {
        let fetchRequest: NSFetchRequest<ChatList> = ChatList.fetchRequest()
        return  coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context).sorted {$0.chatId < $1.chatId}
    }
    
    func getLastMessage(for chatId: Int) -> String {
        let fetchRequest: NSFetchRequest<MessageRecord> = MessageRecord.fetchRequest()
        return  coreDataManager.fetchObjects(fetchRequest: fetchRequest, context: context).filter {$0.chatId == Int32(chatId)}
            .sorted(by: {
            $0.date?.compare($1.date ?? Date.distantFuture) == .orderedAscending
            }).last?.messageText ?? Constants.defaultConversationStarter
    }
}
