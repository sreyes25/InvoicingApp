// InvoiceDetailView.swift

import SwiftUI

struct InvoiceDetailView: View {
    var invoice: Invoice

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Invoice Details")
                .font(.largeTitle)
                .padding()

            Text("Client: \(invoice.client.fullName)")
                .font(.title2)
            Text("Email: \(invoice.client.email)")
                .font(.title3)
                .foregroundColor(.gray)

            Text("Service Description:")
                .font(.headline)
            Text(invoice.serviceDescription)
                .padding(.bottom)

            Text("Total Amount: $\(invoice.totalAmount, specifier: "%.2f")")
                .font(.headline)

            Text("Date Issued: \(invoice.dateFormatted)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Invoice", displayMode: .inline)
    }
}

struct InvoiceDetailView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceDetailView(invoice: Invoice(
            client: Client(fullName: "John Doe", email: "john@example.com"),
            serviceDescription: "Web Design",
            totalAmount: 500.00
        ))
    }
}
