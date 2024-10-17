// ContentView.swift

import SwiftUI

struct ContentView: View {
    @State private var clients: [Client] = [
        Client(fullName: "John Doe", email: "john@example.com"),
        Client(fullName: "Jane Smith", email: "jane@example.com")
    ]
    @State private var invoices: [Invoice] = [
        Invoice(
            client: Client(fullName: "John Doe", email: "john@example.com"),
            serviceDescription: "Web Design",
            totalAmount: 500.00
        )
    ]

    
    var body: some View {
        TabView {
            CreateInvoiceView(clients: $clients, invoices: $invoices)
                .tabItem {
                    Image(systemName: "square.and.pencil")
                    Text("Create Invoice")
                }
            
            ClientsView(clients: $clients)
                .tabItem {
                    Image(systemName: "person.2")
                    Text("Clients")
                }
            
            InvoicesView(invoices: $invoices)
                .tabItem {
                    Image(systemName: "doc.text")
                    Text("Invoices")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
