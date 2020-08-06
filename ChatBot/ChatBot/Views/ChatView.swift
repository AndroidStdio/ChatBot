//
//  ChatView.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit
import os.log

extension ChatView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.getAllMessages().count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = ChatCell()
        let messages = viewModel?.getAllMessages()
        
        switch messages?[indexPath.row].me {
        case true :
            cell.fromLabel.isHidden = true
            cell.toLabel.isHidden = false
            cell.toLabel.text = messages?[indexPath.row].messageText
            
        case false :
            cell.fromLabel.isHidden = false
            cell.toLabel.isHidden = true
            cell.fromLabel.text = messages?[indexPath.row].messageText
            
        case .none:
            fallthrough
        case .some(_):
            os_log("Unreacable enum case reached in ChatView, check the enum")
        }
        cell.selectionStyle = .none
        return cell
    }
}

class ChatView: UIView {
    
    var viewModel: ChatViewModel?
    
    var chatTableView: UITableView?
    var bottomView: UIView?
    var chatTextfield: UITextField?
    var sendButton: UIButton?
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    init(viewModel: ChatViewModel ) {
        self.init()
        self.viewModel = viewModel
        setupView()
    }
    
    private func setupView() {
        backgroundColor = .cityLights
        
        chatTableView = UITableView()
        bottomView = UIView()
        chatTextfield = UITextField()
        sendButton = UIButton()
        
        chatTableView?.translatesAutoresizingMaskIntoConstraints = false
        bottomView?.translatesAutoresizingMaskIntoConstraints = false
        chatTextfield?.translatesAutoresizingMaskIntoConstraints = false
        sendButton?.translatesAutoresizingMaskIntoConstraints = false
        
        if let chatTableView = chatTableView, let bottomView = bottomView, let chatTextfield = chatTextfield, let sendButton = sendButton {
            addSubviews(views: chatTableView, bottomView, chatTextfield, sendButton)
        }
        setupBottomView()
        setupTextField()
        setupButton()
        setupTableView()
        
        setupConstraints()
    }
    
    private func setupBottomView() {
        bottomView?.layer.borderColor = UIColor.black.cgColor
        bottomView?.layer.borderWidth = 1
        bottomView?.backgroundColor = .black
    }
    
    private func setupTextField() {
        chatTextfield?.placeholder = "Type here..."
        chatTextfield?.layer.borderWidth = 0.3
        chatTextfield?.layer.borderColor = UIColor.white.cgColor
        chatTextfield?.layer.cornerRadius = 5
        chatTextfield?.backgroundColor = .white
    }
    
    private func setupButton() {
        sendButton?.setTitle("Send", for: .normal)
        sendButton?.setTitleColor(.white, for: .normal)
    }
    
    private func setupTableView() {
        chatTableView?.dataSource = self
        chatTableView?.delegate = self
        chatTableView?.register(ChatCell.self, forCellReuseIdentifier: "cell")
        chatTableView?.separatorStyle = .none
        chatTableView?.estimatedRowHeight = 50.0
        chatTableView?.rowHeight = UITableView.automaticDimension
        chatTableView?.backgroundColor = .cityLights
        
    }
    
    private func setupConstraints() {
        
        if let chatTableView = chatTableView, let bottomView = bottomView, let chatTextfield = chatTextfield, let sendButton = sendButton {
            NSLayoutConstraint.activate([
                chatTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
                chatTableView.centerYAnchor.constraint(equalTo: centerYAnchor),
                chatTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                chatTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
                chatTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
                
                bottomView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 0),
                bottomView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 0),
                bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 10),
                bottomView.topAnchor.constraint(equalTo: chatTableView.bottomAnchor, constant: 5),
                
                chatTextfield.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
                chatTextfield.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 10),
                chatTextfield.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 5),
                
                sendButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -3),
                sendButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
                sendButton.widthAnchor.constraint(equalToConstant: 100),
                
            ])
        }
    }
}
