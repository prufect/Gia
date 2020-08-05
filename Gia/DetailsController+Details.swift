//
//  DetailsController+Details.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/4/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

extension DetailsController {
    func getDetails() {
        detailsData = [
            .init(name: "Name", content: account.customerName),
            .init(name: "Number", content: account.customerNumber),
            .init(name: "Parent Name", content: account.parentCustomerName),
            .init(name: "Parent Number", content: account.parentCustomerNumber),
        ]
    }
}
