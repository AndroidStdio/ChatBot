//
//  ViewController.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

@objc extension ChatController {
    func keyboardWillShow(notification: NSNotification) {
        if let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue {
            if self.view.frame.origin.y == 0 {
                self.view.frame.origin.y -= keyboardSize.height
            }
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if self.view.frame.origin.y != 0 {
            self.view.frame.origin.y = 0
        }
        
        DispatchQueue.main.async {
            self.chatView?.chatTableView?.reloadData()
        }
    }
    
    func buttonTapped() {
        if let userText = chatView?.chatTextfield?.text, !(userText.isEmpty) {
            switch Reachability.isConnectedToNetwork() {
            case true:
                let userMessage = ChatMessage()
                userMessage.title = userText
                userMessage.who = .me
                viewModel?.messages.append(userMessage)
                
                CoreDataSaveOps.shared.saveMessage(message: userMessage, dateTimeStamp: Date(), who: true)
                
                viewModel?.performChatOperation(userMessage: userText, completion: {
                    [weak self]  result in
                    if result {
                        if let strongSelf = self {
                            DispatchQueue.main.async {
                                strongSelf.chatView?.chatTableView?.reloadData()
                            }
                        }
                    }
                })
            case false:
                let noNetworkMessage = ChatMessage()
                noNetworkMessage.title = "Network not available, I will upload your messages once I am back online"
                noNetworkMessage.who = .chatBot
                
                CoreDataSaveOps.shared.saveMessage(message: noNetworkMessage, dateTimeStamp: Date(), who: false, chatId: UserDefaults.standard.integer(forKey: Constants.chatIdKey))
                
                CoreDataSaveOps.shared.saveOfflineMessage(message: userText, chatId: UserDefaults.standard.integer(forKey: Constants.chatIdKey))
                
                let savedMessaged = ChatMessage()
                savedMessaged.title = "Saved !"
                savedMessaged.who = .chatBot
                
                CoreDataSaveOps.shared.saveMessage(message: savedMessaged, dateTimeStamp: Date(), who: false, chatId: UserDefaults.standard.integer(forKey: Constants.chatIdKey))
            }
            
        } else {
            // alert here
            let alertController = UIAlertController(title: Constants.emptyFieldTitle, message: Constants.emptyFieldMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true)
        }
        
        chatView?.chatTableView?.reloadData()
        chatView?.chatTextfield?.resignFirstResponder()
        chatView?.chatTextfield?.text = ""
    }
    
    func rightBarButtonTapped() {
        navigationController?.pushViewController(ChatSelectionController(), animated: true)
    }
}

class ChatController: UIViewController {
    
    var chatView: ChatView?
    var viewModel: ChatViewModel?
    
    override func loadView() {
        initChatView()
        view = chatView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.white]
        
        handleNewChat()
        
        if CoreDataGetOps.shared.fetchChatList().isEmpty {
            CoreDataSaveOps.shared.saveChatToList(chatId: UserDefaults.standard.integer(forKey: Constants.chatIdKey))
        }
        
        
        self.title = "Chatbot"
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        chatView?.sendButton?.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: self, action: #selector(rightBarButtonTapped))
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        handleNewChat()
        
        uploadChatIfBackOnline()
        chatView?.chatTableView?.reloadData()
    }
    
    func initChatView() {
        viewModel = ChatViewModel()
        if let viewModel = viewModel {
            chatView = ChatView(viewModel: viewModel)
        }
    }
    
    func setStatusBarBackgroundColor(color: UIColor) {
        guard let statusBar = UIApplication.shared.value(forKeyPath: "statusBarWindow.statusBar") as? UIView else { return }
        statusBar.backgroundColor = color
    }
    
    func handleNewChat() {
        if CoreDataGetOps.shared.getAllMessages(chatId: UserDefaults.standard.integer(forKey: Constants.chatIdKey)).isEmpty {
            let chatMessage = ChatMessage()
            chatMessage.title = Constants.defaultConversationStarter
            chatMessage.who = .chatBot
            
            CoreDataSaveOps.shared.saveMessage(message: chatMessage, dateTimeStamp: Date(), who: false)
            
            chatView?.chatTableView?.reloadData()
        }
    }
    
    func uploadChatIfBackOnline() {
        let offlineMessages = CoreDataGetOps.shared.getSavedMessages()
        
        if Reachability.isConnectedToNetwork() && offlineMessages.count > 0 {
            for message in offlineMessages {
                
                DispatchQueue.global(qos: .userInitiated).sync {
                    let chatMessage = ChatMessage()
                    chatMessage.title = message.message
                    chatMessage.who = .me
                    CoreDataSaveOps.shared.saveMessage(message: chatMessage, dateTimeStamp: Date(), who: true, chatId: Int(message.chatId))
                    
                    DispatchQueue.main.async {
                        self.chatView?.chatTableView?.reloadData()
                    }
                    
                    viewModel?.performChatOperation(userMessage: message.message ?? "Hello", chatId: Int(message.chatId), completion: {
                        [weak self]  result in
                        if result {
                            if let strongSelf = self {
                                DispatchQueue.main.async {
                                    strongSelf.chatView?.chatTableView?.reloadData()
                                }
                                CoreDataDeleteOps.shared.deleteOfflineMessages()
                            }
                        }
                    })
                }
            }
        }
    }
}

