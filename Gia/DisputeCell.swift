//
//  DisputeCell.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/5/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class ItemView: UIView {
    
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
    
    init() {
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
    }
    
    private func setupContent() {
        addSubview(content)
        content.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 0).isActive = true
        content.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
    }
}


class DisputeCell: UITableViewCell {
    
    var disputeData: [Detail] = [] {
        didSet {
            number.detail = disputeData[0]
            number.detail = disputeData[1]
            number.detail = disputeData[2]
            number.detail = disputeData[3]
        }
    }
    
    lazy var number: ItemView = {
        let item = ItemView()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var date: ItemView = {
        let item = ItemView()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()

    lazy var tAmount: ItemView = {
        let item = ItemView()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var tDueAmount: ItemView = {
        let item = ItemView()
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()

    private lazy var stack1: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [number, date])
        sv.axis = .horizontal
        sv.alignment = .top
        sv.distribution = .fill
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var stack2: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tAmount, tDueAmount])
        sv.axis = .horizontal
        sv.alignment = .top
        sv.distribution = .fill
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var vStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [stack1, stack2])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fillProportionally
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupStack()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setupStack() {
        contentView.addSubview(vStack)
        vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
        vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
        vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
    }
}
