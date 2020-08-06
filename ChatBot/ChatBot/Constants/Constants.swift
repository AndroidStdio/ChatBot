//
//  Constants.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import Foundation

struct Constants {
    
    static let httpScheme: String = "https"
    static let chatHostName: String = "www.personalityforge.com"
    static let chatPath: String = "/api/chat/"
    
    
    static let fallbackResponse = "Sorry, some error has occoured. Try again..."
    static let emptyFieldTitle = " Warning"
    static let emptyFieldMessage = "The textfield cannot be empty"
    static let defaultConversationStarter = "Hello, How can I help you ?"
    static let chatIdKey = "chatIdKey"
}
