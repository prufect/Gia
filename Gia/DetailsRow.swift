//
//  DetailsRow.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/4/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class DetailsRow: UITableViewCell {
    
    lazy var name: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .caption1)
        l.textColor = .placeholderText
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var content: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textColor = .label
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupName()
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupName() {
        contentView.addSubview(name)
        name.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        name.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupContent() {
        contentView.addSubview(content)
        content.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
    }
}
