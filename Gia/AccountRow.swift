//
//  AccountRow.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class AccountRow: UITableViewCell {
    
    private var icon = UIImageView(image: UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .headline))?.withTintColor(.label, renderingMode: .alwaysOriginal))
    
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .secondarySystemBackground
        
        iv.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: iv.centerXAnchor)
        ])
        
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 22
        iv.clipsToBounds = true
        
        return iv
    }()
    
    private lazy var title: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        return l
    }()
    
    private lazy var subtitle: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .subheadline)
        return l
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
    }
    
    func configure(for account: AccountsData) {
        if let imageData = account.image {
            profileImage.image = UIImage(data: imageData)
            icon.isHidden = true
        } else {
            profileImage.image = nil
            icon.isHidden = false
        }
        
        title.text = account.customerName
        subtitle.text = account.customerNumber
    }
    
    private func setupView() {
        let vstack = UIStackView(arrangedSubviews: [title, subtitle])
        vstack.axis = .vertical
        vstack.distribution = .fillProportionally
        vstack.alignment = .leading
        vstack.spacing = 2
        vstack.translatesAutoresizingMaskIntoConstraints = false

        let hstack = UIStackView(arrangedSubviews: [profileImage, vstack])
        hstack.axis = .horizontal
        hstack.distribution = .fillProportionally
        hstack.alignment = .center
        hstack.spacing = 8
        hstack.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(hstack)
        NSLayoutConstraint.activate([
            profileImage.widthAnchor.constraint(equalToConstant: 44),
            profileImage.heightAnchor.constraint(equalToConstant: 44),
            
            hstack.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            hstack.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            hstack.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            hstack.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
        ])
    }
}
