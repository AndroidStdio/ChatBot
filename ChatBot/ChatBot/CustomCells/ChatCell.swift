//
//  ChatCell.swift
//  ChatBot
//
//  Created by Vishwas Mukund on 8/5/20.
//  Copyright © 2020 Vishwas Mukund. All rights reserved.
//

import UIKit

class ChatCell: UITableViewCell {
    
    var fromLabel: PaddingLabel = {
        var label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.backgroundColor = .wetAsphalt
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.textColor = .white
        
        return label
    } ()
    
    var toLabel: PaddingLabel = {
        var label = PaddingLabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.cornerRadius = 5
        label.layer.borderWidth = 1
        label.backgroundColor = .concrete
        label.clipsToBounds = true
        label.numberOfLines = 0
        label.textColor = .black
        
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
        backgroundColor = .cityLights
        contentView.addSubview(fromLabel)
        contentView.addSubview(toLabel)
        
        setupConstraints()
    }
    
    func setupConstraints() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        NSLayoutConstraint.activate([
            fromLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5),
            fromLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5),
            fromLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 0),
            toLabel.topAnchor.constraint(equalTo: marginGuide.topAnchor, constant: 5),
            toLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5),
            toLabel.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor, constant: 0)
        ])
        
        let fromTrailingConstraint = fromLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: -5)
        let fromWidthConstraint = fromLabel.widthAnchor.constraint(equalToConstant: fromLabel.intrinsicContentSize.width)
        let toLeadingConstraint = toLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor, constant: 5)
        let toWidthConstraint = toLabel.widthAnchor.constraint(equalToConstant: toLabel.intrinsicContentSize.width)
        
        fromTrailingConstraint.priority = UILayoutPriority(rawValue: 999)
        fromWidthConstraint.priority = UILayoutPriority(rawValue: 999)
        toLeadingConstraint.priority = UILayoutPriority(rawValue: 999)
        toWidthConstraint.priority = UILayoutPriority(rawValue: 999)
        
        fromTrailingConstraint.isActive = true
        fromWidthConstraint.isActive = true
        toWidthConstraint.isActive = true
        toLeadingConstraint.isActive = true
    }
}
