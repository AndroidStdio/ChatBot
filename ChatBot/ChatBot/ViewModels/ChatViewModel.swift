//
//  ChatViewModel.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit
import Foundation
import os.log

class ChatViewModel {
    var messages = [ChatMessage]()
    
    func getAllMessages() -> [MessageRecord] {
        return CoreDataGetOps.shared.getAllMessages(chatId: UserDefaults.standard.integer(forKey: Constants.chatIdKey))
    }
    
    
    func performChatOperation(userMessage: String, completion: @escaping (Bool) -> ()) {
        /*
         http://www.personalityforge.com/api/chat/?apiKey=6nt5d1nJHkqbkphe&message=Hi&chatBotID=63906&externalID=chirag1 */
        
        if let url = buildURL(endpoint: .chat, message: userMessage, chatbotId: "63906", externalID: "Vishwas") {

            let request =  NetworkManager.shared.buildRequest(url: url, endpoint: .chat)
            NetworkManager.shared.get(urlRequest: request, completion: {
                [weak self] result in
                switch result {
                case .success(let data):
                    if let strongSelf = self {
                        let chatResponse = strongSelf.parseChatResponse(data: data)
                        let uiMessage = ChatMessage()
                        uiMessage.title = chatResponse
                        uiMessage.who = .chatBot
                        
                        strongSelf.messages.append(uiMessage)
                        
                        CoreDataSaveOps.shared.saveMessage(message: uiMessage, dateTimeStamp: Date(), who: false)
                        
                        completion(true)
                        
                    }
                case .failure(let error):
                    if let strongSelf = self {
                        
                    }
                }
            })
        }
    }
    
    private func buildURL(endpoint: Endpoint, message: String, chatbotId: String, externalID: String ) -> URL? {
        var components = URLComponents()
        components.scheme = Constants.httpScheme
        components.host = Constants.chatHostName
        components.path = Constants.chatPath
        
        switch endpoint {
        case .chat:
            components.queryItems = [
                URLQueryItem(name: "apiKey", value: ApiKey.chatBotKey),
                URLQueryItem(name: "message", value: message),
                URLQueryItem(name: "chatBotID", value: chatbotId),
                URLQueryItem(name: "externalID", value: externalID)
            ]
        }
        
        guard  let url = components.url else {
            return nil
        }
        
        return url
    }
    
    func parseChatResponse(data: Data) -> String {
        let jsonDecoder = JSONDecoder()
        
        var chatResponse: ChatResponse?
        
        do {
            chatResponse = try jsonDecoder.decode(ChatResponse.self, from: data)
        } catch {
            print(error, error.localizedDescription)
            os_log("Error with parsing choices")
        }
        
        return chatResponse?.message.message ?? Constants.fallbackResponse
    }
}
