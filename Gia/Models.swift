//
//  Models.swift
//  Gia
//
//  Created by Prudhvi Gadiraju on 8/3/20.
//  Copyright © 2020 Prudhvi Gadiraju. All rights reserved.
//

import Foundation

// MARK: - Welcome
struct AccountDetails: Codable {
    let success: Bool
    let message: String
    let data: [AccountsDetailsData]
}

// MARK: - Datum
struct AccountsDetailsData: Codable {
    let generalInfo: GeneralInfo
    let accountSummery: AccountSummery
    let customerInfo: CustomerInfo
    let customerContact: CustomerContact
    let internalConact: InternalConact
}

// MARK: - AccountSummery
struct AccountSummery: Codable {
    let balanceDueAmount, currentDueAmount, pastDueAmount, disputeAmount: Int
}

// MARK: - CustomerContact
struct CustomerContact: Codable {
    let phone, fax, contactType, email: String
}

// MARK: - CustomerInfo
struct CustomerInfo: Codable {
    let address1, address2, address3, address4: String
    let city, state, country, postalCode: String
}

// MARK: - GeneralInfo
struct GeneralInfo: Codable {
    let custmerName: String
    let dbRating, lastPaidAmount: Int
    let lastpadiDate, lastCreditReview: String
    let dso: Int
    let creditHoldFlag: Bool
    let creditLimit: Int
    let paymentTerm: String
}

// MARK: - InternalConact
struct InternalConact: Codable {
    let purchangeRep, outsideSalesRep, serviceRep, creditRep: String
}

// MARK: - Welcome
struct Accounts: Codable {
    let success: Bool
    let message: String
    let data: [AccountsData]
}

// MARK: - Datum
struct AccountsData: Codable, Hashable {
    var image: Data?
    var isFavorite: Bool = false
    let customerNumber, customerName, parentCustomerNumber, parentCustomerName: String

    enum CodingKeys: String, CodingKey {
        case customerNumber, customerName, parentCustomerNumber, image
        case parentCustomerName = "ParentCustomerName"
    }
}

// MARK: - Welcome
struct Disputes: Codable {
    let success: Bool
    let message: String
    let data: [DisputesData]
}

// MARK: - Datum
struct DisputesData: Codable {
    let disputeNumber, transactionDate: String
    let transactionAmount, transactionDueAmount: Int
    let approvedAmount: Double

    enum CodingKeys: String, CodingKey {
        case disputeNumber, transactionDate, transactionAmount, transactionDueAmount
        case approvedAmount = "ApprovedAmount"
    }
}

// MARK: - Welcome
struct Invoices: Codable {
    let success: Bool
    let message: String
    let data: [InvoicesData]
}

// MARK: - Datum
struct InvoicesData: Codable {
    let businessUnit, transactionNumber, transactionDate, transactionDueDate: String
    let transactionAmount, transactionDueAmount: Int
}

// MARK: - Welcome
struct Payments: Codable {
    let success: Bool
    let message: String
    let data: [PaymentsData]
}

// MARK: - Datum
struct PaymentsData: Codable {
    let paymentNumber, paymentDate: String
    let paymentAmount: Int
}
