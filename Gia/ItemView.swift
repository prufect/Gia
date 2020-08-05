//
//  ItemView.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/5/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
    var left: Bool = true
    
    var detail: Detail? = nil {
        didSet {
            name.text = detail!.name
            content.text = detail!.content
        }
    }
    
    lazy var name: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .caption1)
        l.textColor = .placeholderText
        l.text = "Testing"
        l.textAlignment = left ? .left : .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    lazy var content: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .headline)
        l.textColor = .label
        l.text = "More Testing"
        l.textAlignment = left ? .left : .right
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    init(left: Bool) {
        self.left = left
        super.init(frame: .zero)
        
        setupName()
        setupContent()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupName() {
        addSubview(name)
        name.topAnchor.constraint(equalTo: topAnchor, constant: 4).isActive = true
        name.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        name.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
    
    private func setupContent() {
        addSubview(content)
        content.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        content.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -4).isActive = true
        content.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
    }
}
