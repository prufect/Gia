//
//  UIViewController+Add.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import UIKit

extension UIViewController {
    func add(_ childController: UIViewController, to view: UIView? = nil) {
        let view: UIView = view ?? self.view
        
        self.addChild(childController)
        childController.view.frame = view.frame
        view.addSubview(childController.view)
        childController.didMove(toParent: self)
    }
    
    func remove() {
        willMove(toParent: nil)
        view.removeFromSuperview()
        removeFromParent()
    }
}
