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
    private var filteredAccounts: [AccountsData] = []
    
    init() {
        super.init(nibName: nil, bundle: nil)
        accounts = storage.getAllAccounts()
        filteredAccounts = accounts
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: true)
        navigationItem.hidesSearchBarWhenScrolling = false
    }
    
    override func viewDidAppear(_ animated: Bool) {
        navigationItem.hidesSearchBarWhenScrolling = true
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
        if filteredAccounts.count == 0 {
            let v = UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: tableView.frame.height/1.5))
            tableView.tableHeaderView = v
            add(EmptyListController(), to: v)
        } else {
            tableView.tableHeaderView = nil
        }
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
        return filteredAccounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell2", for: indexPath) as! AccountRow
        let account = filteredAccounts[indexPath.row]
        cell.configure(for: account)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let account = filteredAccounts[indexPath.row]
            filteredAccounts.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
            
            if let index = accounts.firstIndex(of: account) {
                accounts.remove(at: index)
            }
            
            storage.save(accounts)
            setupView()
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let account = filteredAccounts[indexPath.row]
        let detailsController = DetailsController(account: account)
        
        detailsController.updateImage = { [weak self] image in
            guard let self = self else { return }
            if let index = self.filteredAccounts.firstIndex(of: account) {
                self.filteredAccounts[index].image = image.pngData()
                tableView.reloadRows(at: [indexPath], with: .automatic)
            }
            
            if let index = self.accounts.firstIndex(of: account) {
                self.accounts[index].image = image.pngData()
                self.storage.save(self.accounts)
            }
        }
        
        if navigationItem.searchController!.isActive {
            print("Dismiss Search")
            dismiss(animated: true, completion: {
                self.navigationController?.pushViewController(detailsController, animated: true)
            })
        } else {
            navigationController?.pushViewController(detailsController, animated: true)
        }
    }
}

extension HomeController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        if let text = searchController.searchBar.text {
            if text.isEmpty {
                filteredAccounts = accounts
            } else {
                filteredAccounts = accounts.filter { $0.customerName.contains(text) }
            }
        }
        
        tableView.reloadData()
    }
}

extension HomeController: AddAccountControllerDelegate {
    func add(_ account: AccountsData) {
        setupView()
        filteredAccounts.append(account)
        accounts.append(account)
        tableView.insertRows(at: [IndexPath(row: filteredAccounts.count-1, section: 0)], with: .automatic)
        storage.save(filteredAccounts)
        setupView()
    }
}
