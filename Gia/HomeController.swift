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
    
    private lazy var tableView: UITableView = {
        let tv = UITableView()
        tv.delegate = self
        tv.dataSource = self
        tv.translatesAutoresizingMaskIntoConstraints = false
        tv.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell2")
        return tv
    }()
    
    private var accounts: [AccountsData] = [] {
        didSet {
            tableView.reloadData()
            setupView()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
        setupView()
        setupTableView()
    }
    
    @objc func onAddTapped() {
        let addAccountController = UINavigationController(rootViewController:
            AddAccountController(onAccountTap: { [weak self] accountsData in
                self?.accounts.append(accountsData)
            }))
        
        present(addAccountController, animated: true, completion: nil)
    }
    
    private func setupView() {
        if accounts.isEmpty {
            tableView.isHidden = true
            emptyListController = EmptyListController()
            add(emptyListController!)
        } else {
            tableView.isHidden = false
            if emptyListController != nil {
                emptyListController?.remove()
                emptyListController = nil
            }
        }
    }
    
    private func setupNav() {
        title = "Accounts"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(onAddTapped))
    }
    
    private func setupTableView() {
        view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension HomeController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell2", for: indexPath)
        cell.textLabel?.text = accounts[indexPath.row].customerName
        return cell
    }
}
