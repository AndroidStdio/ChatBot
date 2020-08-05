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
        return viewModel?.messages.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as? ChatCell else { return UITableViewCell() }
        
        switch viewModel?.messages[indexPath.row].who {
        case .me :
            cell.fromLabel.isHidden = true
            cell.toLabel.isHidden = false
            cell.toLabel.text = viewModel?.messages[indexPath.row].title
            
        case .chatBot :
            cell.fromLabel.isHidden = false
            cell.toLabel.isHidden = true
            cell.fromLabel.text = viewModel?.messages[indexPath.row].title
            
        case .none:
            os_log("Unreacable enum case reached in ChatView, check the enum")
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
        backgroundColor = .white
        
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
        
        setupTextField()
        setupButton()
        setupTableView()
        
        setupConstraints()
    }
    
    private func setupTextField() {
        chatTextfield?.placeholder = "Type here..."
        chatTextfield?.layer.borderWidth = 0.3
        chatTextfield?.layer.borderColor = UIColor.black.cgColor
        chatTextfield?.layer.cornerRadius = 5
    }
    
    private func setupButton() {
        sendButton?.setTitle("Send", for: .normal)
        sendButton?.setTitleColor(.black, for: .normal)
    }
    
    private func setupTableView() {
        chatTableView?.dataSource = self
        chatTableView?.delegate = self
        chatTableView?.register(ChatCell.self, forCellReuseIdentifier: "cell")
        chatTableView?.separatorStyle = .none
    }
    
    private func setupConstraints() {
        
        if let chatTableView = chatTableView, let bottomView = bottomView, let chatTextfield = chatTextfield, let sendButton = sendButton {
            NSLayoutConstraint.activate([
                chatTableView.centerXAnchor.constraint(equalTo: centerXAnchor),
                chatTableView.centerYAnchor.constraint(equalTo: centerYAnchor),
                chatTableView.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 10),
                chatTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor, constant: 5),
                chatTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -5),
                
                bottomView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
                bottomView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5),
                bottomView.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: 0),
                bottomView.topAnchor.constraint(equalTo: chatTableView.bottomAnchor, constant: 5),
                
                chatTextfield.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
                chatTextfield.leadingAnchor.constraint(equalTo: bottomView.leadingAnchor, constant: 3),
                chatTextfield.trailingAnchor.constraint(equalTo: sendButton.leadingAnchor, constant: 3),
                
                sendButton.trailingAnchor.constraint(equalTo: bottomView.trailingAnchor, constant: -3),
                sendButton.centerYAnchor.constraint(equalTo: bottomView.centerYAnchor),
                sendButton.widthAnchor.constraint(equalToConstant: 100),
                
            ])
        }
    }
}
