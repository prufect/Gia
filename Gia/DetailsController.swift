//
//  DetailsController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

class DetailsController: UIViewController {
    var account: AccountsData
    
    private lazy var backButton: UIButton = {
        let b = UIButton()
        b.setImage(UIImage(systemName: "arrow.left", withConfiguration: UIImage.SymbolConfiguration(textStyle: .largeTitle)), for: .normal)
        b.addTarget(self, action: #selector(onBackTapped), for: .touchUpInside)
        b.translatesAutoresizingMaskIntoConstraints = false
        return b
    }()
    
    private lazy var name: UILabel = {
        let l = UILabel()
        l.font = UIFont.preferredFont(forTextStyle: .largeTitle)
        l.text = account.customerName
        l.translatesAutoresizingMaskIntoConstraints = false
        return l
    }()
    
    private lazy var profileImage: UIImageView = {
        let iv = UIImageView()
        iv.backgroundColor = .secondarySystemBackground
        
        let icon = UIImageView(image: UIImage(systemName: "person.fill", withConfiguration: UIImage.SymbolConfiguration(textStyle: .headline))?.withTintColor(.label, renderingMode: .alwaysOriginal))
            iv.addSubview(icon)
        icon.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            icon.centerYAnchor.constraint(equalTo: iv.centerYAnchor),
            icon.centerXAnchor.constraint(equalTo: iv.centerXAnchor)
        ])
        
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 45
        iv.clipsToBounds = true
        
    
        return iv
    }()
    
    private lazy var segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["1", "2", "3", "4"])
        sc.selectedSegmentIndex = 0
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    init(account: AccountsData) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupNav()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupBack()
        setupProfileImage()
        setupName()
        setupSegmentedController()
    }
    
    @objc func onBackTapped() {
        navigationController?.popViewController(animated: true)
    }
    
    private func setupNav() {
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    private func setupBack() {
        view.addSubview(backButton)
        backButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16).isActive = true
        backButton.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16).isActive = true
    }
    
    private func setupProfileImage() {
        view.addSubview(profileImage)
        profileImage.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 24).isActive = true
        profileImage.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        profileImage.widthAnchor.constraint(equalToConstant: 90).isActive = true
        profileImage.heightAnchor.constraint(equalToConstant: 90).isActive = true
    }
    
    private func setupName() {
        view.addSubview(name)
        name.topAnchor.constraint(equalTo: profileImage.bottomAnchor, constant: 8).isActive = true
        name.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
    }
    
    private func setupSegmentedController() {
        view.addSubview(segmentedControl)
        segmentedControl.topAnchor.constraint(equalTo: name.bottomAnchor, constant: 16).isActive = true
        segmentedControl.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 32).isActive = true
        segmentedControl.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -32).isActive = true
        segmentedControl.heightAnchor.constraint(equalToConstant: 32).isActive = true
    }
}
