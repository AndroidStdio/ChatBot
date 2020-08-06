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
            chatView?.chatTableView?.reloadData()
            chatView?.chatTextfield?.resignFirstResponder()
            chatView?.chatTextfield?.text = ""
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
        } else {
            // alert here
            let alertController = UIAlertController(title: Constants.emptyFieldTitle, message: Constants.emptyFieldMessage, preferredStyle: .alert)
            alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
            present(alertController, animated: true)
        }
    }
    
    func rightBarButtonTapped() {
        
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
        
        self.title = "Chatbot"
        
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.backgroundColor = .black
        navigationController?.navigationBar.barStyle = .black
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
        
        chatView?.sendButton?.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
        
    }
    
    func initChatView() {
        viewModel = ChatViewModel()
        if let viewModel = viewModel {
            chatView = ChatView(viewModel: viewModel)
        }
        
    }
}

