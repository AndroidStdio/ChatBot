//
//  ChatSelectionView.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/6/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

extension ChatSelectionView: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle, reuseIdentifier: "cell")
        cell.textLabel?.text = "Chat Id : 1"
        cell.detailTextLabel?.text = "Blah blah"
        cell.accessoryType = .checkmark
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
    
    
}

class ChatSelectionView: UIView {

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    var selectionTableView = UITableView()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupView() {
        backgroundColor = .cityLights
        selectionTableView.translatesAutoresizingMaskIntoConstraints = false
        selectionTableView.dataSource = self
        selectionTableView.delegate = self
        selectionTableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        
        addSubview(selectionTableView)
        
        setupConstraints()
    }
    
    private func setupConstraints() {
        NSLayoutConstraint.activate([
            selectionTableView.leadingAnchor.constraint(equalTo: safeAreaLayoutGuide.leadingAnchor),
            selectionTableView.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor),
            selectionTableView.topAnchor.constraint(equalTo: topAnchor),
            selectionTableView.bottomAnchor.constraint(equalTo: bottomAnchor),
        ])
    }
    
}
