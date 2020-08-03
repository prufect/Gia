//
//  HomeController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class HomeController: UIViewController {
    
    private var emptyListController: EmptyListController? = nil
    private var accountTableController: AccountsTableController? = nil
    
    private var accountsData: [AccountsData] = [] {
        didSet {
            accountTableController?.reload()
            setupView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupView()
    }
    
    @objc func onAddTapped() {
        let addAccountController = UINavigationController(rootViewController:
            AddAccountController(onAccountTap: { [weak self] accountsData in
                self?.accountsData.append(accountsData)
            }))
        
        present(addAccountController, animated: true, completion: nil)
    }
    
    private func setupView() {
        if accountsData.isEmpty {
            if accountTableController != nil {
                accountTableController?.remove()
                accountTableController = nil
            }
            add(EmptyListController())
        } else {
            if emptyListController != nil {
                emptyListController?.remove()
                emptyListController = nil
            }
            add(AccountsTableController(with: accountsData))
        }
    }
    
    private func setupNav() {
        title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddTapped))
    }
}
