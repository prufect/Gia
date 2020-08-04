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
    private var accounts: [AccountsData] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        accounts = storage.getAllAccounts()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupSearch()
        setupTableView()
        setupView()
    }
    
    @objc func onAddTapped() {
        let addAccountController = AddAccountController()
        addAccountController.delegate = self
        
        present(UINavigationController(rootViewController: addAccountController), animated: true, completion: nil)
    }
    
    func reload() {
        print("Reload")
        storage.save(accounts)
        tableView.reloadData()
        setupView()
    }
    
    private func setupView() {
//        if accounts.count == 0 {
//            add(EmptyListController(), to: tableView.tableFooterView)
//        } else {
//            tableView.tableFooterView = UIView()
//        }
    }
    
    private func setupNav() {
        title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddTapped))
    }
    
    private func setupTableView() {
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(AccountRow.self, forCellReuseIdentifier: "AccountCell2")
        tableView.estimatedRowHeight = 44
        tableView.tableFooterView = UIView()
    }
    
    private func setupSearch() {
        let searchController = UISearchController()
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
    }
}

extension HomeController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell2", for: indexPath) as! AccountRow
        let account = accounts[indexPath.row]
        cell.configure(for: account)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let account = accounts[indexPath.row]
            if let index = accounts.firstIndex(of: account) {
                accounts.remove(at: index)
            }
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if navigationItem.searchController!.isActive { dismiss(animated: true, completion: nil) }
        let account = accounts[indexPath.row]
        let detailsController = DetailsController(account: account)
        
        detailsController.updateImage = { [weak self] image in
            guard let self = self else { return }
            if let index = self.accounts.firstIndex(of: account) {
                self.accounts[index].image = image.pngData()
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
        }
        
        navigationController?.pushViewController(detailsController, animated: true)
    }
}

extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
//        if let text = searchController.searchBar.text {
//            if text.isEmpty {
//                filteredAccounts = accounts
//            } else {
//                filteredAccounts = accounts.filter { $0.customerName.contains(text) }
//            }
//        }
    }
}

extension HomeController: AddAccountControllerDelegate {
    func add(_ account: AccountsData) {
        accounts.append(account)
        tableView.insertRows(at: [IndexPath(row: accounts.count-1, section: 0)], with: .automatic)
    }
}
