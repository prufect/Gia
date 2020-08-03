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
    
    init(account: AccountsData) {
        self.account = account
        super.init(nibName: nil, bundle: nil)
        view.backgroundColor = .systemBackground
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupNav()
    }
    
    private func setupNav() {
        title = account.customerName
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
