//
//  UITableViewController+EmptyView.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

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
