//
//  AddAccountController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

protocol AddAccountControllerDelegate: AnyObject {
    func add(_ account: AccountsData)
}

final class AddAccountController: UITableViewController {
    
    private var filteredAccounts: [AccountsData] = []
    private var accounts: [AccountsData] = Bundle.main.decode(Accounts.self, from: "accounts.json").data
    
    weak var delegate: AddAccountControllerDelegate? = nil
    
    init() {
        super.init(nibName: nil, bundle: nil)
        filteredAccounts = accounts
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
        setupSearch()
        setupTableView()
    }
    
    @objc func onDoneTapped() {
        dismiss(animated: true, completion: nil)
    }
    
    private func setupNavBar() {
        title = "Add an Account"
        navigationController?.navigationBar.prefersLargeTitles = false
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(onDoneTapped))
    }
    
    private func setupSearch() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell")
    }
}

extension AddAccountController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filteredAccounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath)
        cell.textLabel?.text = filteredAccounts[indexPath.row].customerName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.add(filteredAccounts[indexPath.row])
        
        if navigationItem.searchController!.isActive {
            self.dismiss(animated: false, completion: nil)
        }
        
        self.dismiss(animated: true, completion: nil)
    }
}

extension AddAccountController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            if text.isEmpty {
                filteredAccounts = accounts
            } else {
                filteredAccounts = accounts.filter { $0.customerName.contains(text) }
            }
            
            tableView.reloadData()
        }
    }
}
