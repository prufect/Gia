//
//  DisputeCell.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/5/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class DisputeCell: UIView {
    
    var disputeData: [Detail] = [] {
        didSet {
            number.detail = disputeData[0]
            date.detail = disputeData[1]
            tAmount.detail = disputeData[2]
            tDueAmount.detail = disputeData[3]
            approvedAmount.detail = disputeData[4]
        }
    }
    
    lazy var number: ItemView = {
        let item = ItemView(left: true)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var date: ItemView = {
        let item = ItemView(left: false)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()

    lazy var tAmount: ItemView = {
        let item = ItemView(left: true)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var tDueAmount: ItemView = {
        let item = ItemView(left: false)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()
    
    lazy var approvedAmount: ItemView = {
        let item = ItemView(left: false)
        item.translatesAutoresizingMaskIntoConstraints = false
        return item
    }()

    private lazy var stack1: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [number, date])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var stack2: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [tAmount, tDueAmount])
        sv.axis = .horizontal
        sv.alignment = .fill
        sv.distribution = .equalSpacing
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var stack3: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [approvedAmount])
        sv.axis = .horizontal
        sv.alignment = .trailing
        sv.distribution = .equalSpacing
        sv.spacing = 4
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var vStack: UIStackView = {
        let sv = UIStackView(arrangedSubviews: [stack1, stack2, stack3])
        sv.axis = .vertical
        sv.alignment = .fill
        sv.distribution = .fill
        sv.spacing = 8
        sv.translatesAutoresizingMaskIntoConstraints = false
        return sv
    }()
    
    private lazy var bgView: UIView = {
        let v = UIView(frame: .init(x: 0, y: 0, width: self.bounds.width, height: 120))
        v.backgroundColor = .secondarySystemBackground
        v.layer.cornerRadius = 12
        v.clipsToBounds = true
        v.translatesAutoresizingMaskIntoConstraints = false
        return v
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupBG()
        setupName()
//        setupDate()
//        setupStack()
    }
    
    private func setupBG() {
        addSubview(bgView)
        bgView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16).isActive = true
        bgView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16).isActive = true
        bgView.topAnchor.constraint(equalTo: topAnchor, constant: 8).isActive = true
        bgView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupName() {
        bgView.addSubview(vStack)
        vStack.leadingAnchor.constraint(equalTo: bgView.leadingAnchor, constant: 8).isActive = true
        vStack.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 8).isActive = true
        vStack.trailingAnchor.constraint(equalTo: bgView.trailingAnchor, constant: -8).isActive = true
        vStack.bottomAnchor.constraint(equalTo: bgView.bottomAnchor, constant: -8).isActive = true
    }
    
    private func setupDate() {
        bgView.addSubview(date)
        date.leadingAnchor.constraint(equalTo: number.trailingAnchor, constant: 8).isActive = true
        date.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -8).isActive = true
        date.topAnchor.constraint(equalTo: bgView.topAnchor, constant: 8).isActive = true
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    private func setupStack() {
//        addSubview(vStack)
//        vStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 4).isActive = true
//        vStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 16).isActive = true
//        vStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -16).isActive = true
//        vStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -4).isActive = true
//    }
}
