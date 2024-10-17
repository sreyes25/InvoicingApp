//
//  Invoice.swift
//  InvoicingApp
//
//  Created by Sergio Reyes on 10/17/24.
//
// Invoice.swift

import Foundation

struct Invoice: Identifiable, Hashable {
    var id: UUID = UUID()
    var client: Client
    var serviceDescription: String
    var totalAmount: Double
    var date: Date = Date()
}

extension Invoice {
    var dateFormatted: String {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter.string(from: date)
    }
}
