//
//  ChatSelectionController.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/6/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

@objc extension ChatSelectionController {
    func rightBarButtonTapped() {
        let numberOfChats = CoreDataGetOps.shared.fetchChatList().count - 1
        CoreDataSaveOps.shared.saveChatToList(chatId: numberOfChats + 1)
        UserDefaults.standard.set(numberOfChats + 1, forKey: Constants.chatIdKey)
        navigationController?.popViewController(animated: true)
    }
}

class ChatSelectionController: UIViewController {
    
    var selectionView: ChatSelectionView?
    
    override func loadView() {
        selectionView = ChatSelectionView()
        selectionView?.viewController = self
        if let selectionView = selectionView {
            view = selectionView
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
    }
}
