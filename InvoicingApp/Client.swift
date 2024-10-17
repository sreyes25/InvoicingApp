//
//  Client.swift
//  InvoicingApp
//
//  Created by Sergio Reyes on 10/16/24.
//
import Foundation

struct Client: Identifiable, Hashable {
    var id: UUID = UUID()
    var fullName: String
    var email: String
}
