//
//  AddAccountController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class AddAccountController: UITableViewController {
    
    private var accounts: [AccountsData] = Bundle.main.decode(Accounts.self, from: "accounts.json").data
    private var onAccountTap: (AccountsData) -> ()
    
    init(onAccountTap: @escaping (AccountsData) -> ()) {
        self.onAccountTap = onAccountTap
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNavBar()
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
    
    private func setupTableView() {
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "AccountCell")
    }
}

extension AddAccountController {
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return accounts.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "AccountCell", for: indexPath)
        cell.textLabel?.text = accounts[indexPath.row].customerName
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        onAccountTap(accounts[indexPath.row])
        dismiss(animated: true, completion: nil)
    }
}
