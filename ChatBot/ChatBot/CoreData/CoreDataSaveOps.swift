//
//  CoreDataSaveOps.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import CoreData
import Foundation

class CoreDataSaveOps {
    let coreDataManager = CoreDataManager.shared
    let context = CoreDataManager.shared.mainContext
    static let shared = CoreDataSaveOps()
    
    private init() {}

    func saveMessage(message: ChatMessage, dateTimeStamp: Date, who: Bool) {
        let messageManagedObject = MessageRecord(context: context)
        
        messageManagedObject.messageText = message.title
        messageManagedObject.date = dateTimeStamp
        messageManagedObject.me = who
        messageManagedObject.chatId = Int32(UserDefaults.standard.integer(forKey: Constants.chatIdKey))
        
        
        coreDataManager.saveContext(context: context)
    }
    
    func saveChatToList(chatId: Int) {
        let chatManagedObject = ChatList(context: context)
        chatManagedObject.chatId = Int32(chatId)
        
        coreDataManager.saveContext(context: context)
        
    }
}
