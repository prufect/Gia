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
        let accountDetails = Bundle.main.decode(AccountDetails.self, from: "acctdetails.json").data
        let disputes = Bundle.main.decode(Disputes.self, from: "disputes.json").data
        let invoices = Bundle.main.decode(Invoices.self, from: "invoices.json").data
        let payments = Bundle.main.decode(Payments.self, from: "payments.json").data

        detailsData = [
            .init(name: "Name", content: account.customerName),
            .init(name: "Number", content: account.customerNumber),
            .init(name: "Parent Name", content: account.parentCustomerName),
            .init(name: "Parent Number", content: account.parentCustomerNumber),
            .init(name: "DB Rating", content: "\(accountDetails[0].generalInfo.dbRating)"),
            .init(name: "Last Paid Ammount", content: "$\(accountDetails[0].generalInfo.lastPaidAmount).00"),
            .init(name: "Last Paid Date", content: accountDetails[0].generalInfo.lastpadiDate),
            .init(name: "Last Credit Review", content: accountDetails[0].generalInfo.lastCreditReview),
            .init(name: "Credit Hold Flag", content: accountDetails[0].generalInfo.creditHoldFlag ? "True" : "False"),
            .init(name: "Credit Limit", content: "$\(accountDetails[0].generalInfo.creditLimit).00"),
            .init(name: "Payment Term", content: accountDetails[0].generalInfo.paymentTerm),
        ]
        
        disputesData = [
            .init(name: "Dispute Number", content: disputes[0].disputeNumber),
            .init(name: "Transaction Date", content: disputes[0].transactionDate),
            .init(name: "Transaction Amount", content: "$\(disputes[0].transactionAmount).00"),
            .init(name: "Transaction Due Amount", content: "$\(disputes[0].transactionDueAmount).00"),
            .init(name: "Approved Amount", content: "$\(disputes[0].approvedAmount).00"),
        ]
        
        invoicesData = [
            .init(name: "Business Unit", content: invoices[0].businessUnit),
            .init(name: "Transaction Number", content: invoices[0].transactionNumber),
            .init(name: "Transaction Date", content: invoices[0].transactionDate),
            .init(name: "Transaction Due Date", content: invoices[0].transactionDueDate),
            .init(name: "Transaction Amount", content: "$\(invoices[0].transactionAmount).00"),
            .init(name: "Transaction Due Amount", content: "$\(invoices[0].transactionDueAmount).00"),
        ]
        
        paymentsData = [
            .init(name: "Payment Number", content: payments[0].paymentNumber),
            .init(name: "Payment Date", content: payments[0].paymentDate),
            .init(name: "Payment Amount", content: "$\(payments[0].paymentAmount).00")
        ]
    }
}
