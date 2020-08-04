//
//  EmptyListController.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

final class EmptyListController: UIViewController {
    
    private lazy var emptyImage: UIImageView = {
        let image = UIImage(named: "EmptyListImage")!.withTintColor(.secondarySystemBackground, renderingMode: .automatic)
        let iv = UIImageView(image: image)
        iv.contentMode = .scaleAspectFit
        iv.translatesAutoresizingMaskIntoConstraints = false
        return iv
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupImage()
    }
    
    private func setupImage() {
        view.addSubview(emptyImage)
        NSLayoutConstraint.activate([
            emptyImage.topAnchor.constraint(equalTo: view.topAnchor),
            emptyImage.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            emptyImage.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            emptyImage.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
