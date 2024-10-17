import SwiftUI

struct InvoicesView: View {
    @Binding var invoices: [Invoice]

    var body: some View {
        NavigationView {
            List {
                ForEach(invoices) { invoice in
                    NavigationLink(destination: InvoiceDetailView(invoice: invoice)) {
                        VStack(alignment: .leading) {
                            Text("Client: \(invoice.client.fullName)")
                                .font(.headline)
                            Text("Service: \(invoice.serviceDescription)")
                            Text("Amount: $\(invoice.totalAmount, specifier: "%.2f")")
                            Text("Date: \(invoice.dateFormatted)")
                                .font(.caption)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteInvoice)
            }
            .navigationBarTitle("Invoices")
        }
    }

    func deleteInvoice(at offsets: IndexSet) {
        invoices.remove(atOffsets: offsets)
    }
}

struct InvoicesView_Previews: PreviewProvider {
    static var previews: some View {
        InvoicesView(invoices: .constant([
            Invoice(
                client: Client(fullName: "John Doe", email: "john@example.com"),
                serviceDescription: "Web Design",
                totalAmount: 500.00
            ),
            Invoice(
                client: Client(fullName: "Jane Smith", email: "jane@example.com"),
                serviceDescription: "Consultation",
                totalAmount: 300.00
            )
        ]))
    }
}
