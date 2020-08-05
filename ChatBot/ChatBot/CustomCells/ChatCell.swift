//
//  ChatCell.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    var fromLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.backgroundColor = .blue
        label.clipsToBounds = true
        label.numberOfLines = 0
        
        return label
    } ()
    
    var toLabel: UILabel = {
        var label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 10
        label.layer.borderWidth = 1
        label.backgroundColor = .gray
        label.clipsToBounds = true
        label.numberOfLines = 0

        return label
    } ()
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        setupView()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupView()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    func setupView() {
        contentView.addSubview(fromLabel)
        contentView.addSubview(toLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        fromLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5).isActive = true
       // fromLabel.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        fromLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5).isActive = true
        //fromLabel.heightAnchor.constraint(equalTo: heightAnchor, constant: -5).isActive = true
        fromLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5).isActive = true
        fromLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 0).isActive = true
        
        toLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5).isActive = true
        toLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5).isActive = true
        toLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 0).isActive = true
      
        
        
    }
}
