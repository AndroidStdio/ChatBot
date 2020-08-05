//
//  ViewController.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

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
        
        let m1 = Message()
        m1.title = "Hi, whats up man ? "
        m1.who = .me
        
        let m2 = Message()
        m2.title = "Who is this?"
        m2.who = .chatBot
        
        let m3 = Message()
        m3.title = "This is the Po Po"
        m3.who = .me
        
        let m4 = Message()
        m4.title = "New phone"
        m4.who = .chatBot
        
        
        viewModel?.messages.append(m1)
        viewModel?.messages.append(m2)
        viewModel?.messages.append(m3)
        viewModel?.messages.append(m4)
        
    }
    
    func initChatView() {
        viewModel = ChatViewModel()
        if let viewModel = viewModel {
            chatView = ChatView(viewModel: viewModel)
        }
    }
    
    
}

