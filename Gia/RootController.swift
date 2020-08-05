//
//  RootController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class RootController: UITabBarController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        view.backgroundColor = .systemBackground
        
        let favoritesController = UINavigationController(rootViewController: FavoritesController())
        favoritesController.tabBarItem = UITabBarItem(tabBarSystemItem: .favorites, tag: 0)
        
        let homeController = UINavigationController(rootViewController: HomeController())
        homeController.tabBarItem = UITabBarItem(tabBarSystemItem: .contacts, tag: 0)
        
        viewControllers = [
            favoritesController,
            homeController,
        ]
    }
    
    private func showHomeController() {
        let homeController = UINavigationController(rootViewController: HomeController())
        homeController.modalPresentationStyle = .fullScreen
        present(homeController, animated: false)
    }
}

