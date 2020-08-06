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

        // Do any additional setup after loading the view.
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(rightBarButtonTapped))
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
