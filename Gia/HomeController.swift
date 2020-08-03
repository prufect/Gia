//
//  HomeController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class HomeController: UIViewController {
    var accountsData: [AccountsData] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupView()
    }
    
    @objc func onAddTapped() {
        print("Tapped Add")
    }
    
    private func setupView() {
        if accountsData.isEmpty {
            add(EmptyListController())
        } else {
            add(AccountsTableController())
        }
    }
    
    private func setupNav() {
        title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddTapped))
    }
}
