//
//  RootController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class RootController: UIViewController {
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        showHomeController()
    }
    
    private func showHomeController() {
        let homeController = HomeController()
        homeController.modalPresentationStyle = .fullScreen
        present(homeController, animated: false)
    }
}

