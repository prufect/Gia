//
//  AccountsTableController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class AccountsTableController: UITableViewController {
    
    private var accounts: [AccountsData] = []
    
    init(with accounts: [AccountsData]) {
        self.accounts = accounts
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupTableView()
    }
    
    func reload() {
        tableView.reloadData()
    }
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell2")
    }
}

extension AccountsTableController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell2", for: indexPath)
        cell.textLabel?.text = accounts[indexPath.row].customerName
        return cell
    }
}
