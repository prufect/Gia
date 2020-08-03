//
//  HomeController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class HomeController: UITableViewController {
    
    private var storage = AccountsStore()
    
    private var accounts: [AccountsData] = [] {
        didSet { reload() }
    }
    
    init() {
        super.init(nibName: nil, bundle: nil)
        accounts = storage.getAllAccounts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupSearch()
        setupTableView()
    }
    
    @objc func onAddTapped() {
        let addAccountController = UINavigationController(rootViewController:
            AddAccountController(onAccountTap: { [weak self] accountsData in
                self?.accounts.append(accountsData)
            }))
        
        present(addAccountController, animated: true, completion: nil)
    }
    
    func reload() {
        storage.save(accounts)
        
        tableView.reloadData()
        if accounts.count == 0 {
            showEmptyView()
        } else {
            removeEmptyView()
        }
    }
    
    private func setupNav() {
        title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddTapped))
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell2")
    }
    
    private func setupSearch() {
        let searchController = UISearchController()
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell2", for: indexPath)
        cell.textLabel?.text = accounts[indexPath.row].customerName
        return cell
    }
}

extension UITableViewController {
    func showEmptyView() {
        tableView.separatorStyle = .none
        tableView.isScrollEnabled = false
        tableView.backgroundView = UIView()
        add(EmptyListController(), to: tableView.backgroundView)
    }
    
    func removeEmptyView() {
        tableView.isScrollEnabled = true
        tableView.separatorStyle = .singleLine
        tableView.backgroundView = nil
    }
}
