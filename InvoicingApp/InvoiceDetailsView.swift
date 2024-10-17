import SwiftUI

struct InvoiceDetailsView: View {
    @Environment(\.presentationMode) var presentationMode

    @State var invoice: Invoice // Marked as @State to allow mutation
    @Binding var clients: [Client]
    @Binding var invoices: [Invoice]
    var onConfirm: (() -> Void)? // Optional closure

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Invoice Preview")
                .font(.largeTitle)
                .padding()

            Text("Client: \(invoice.client.fullName)")
                .font(.title2)
            Text("Email: \(invoice.client.email)")
                .font(.title3)
                .foregroundColor(.gray)
            Text("Service: \(invoice.serviceDescription)")
                .font(.headline)
            Text("Total Amount: $\(invoice.totalAmount, specifier: "%.2f")")
                .font(.headline)
            Text("Date: \(invoice.dateFormatted)")
                .font(.subheadline)
                .foregroundColor(.gray)

            Spacer()

            HStack {
                Button(action: {
                    // Go back to editing
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Edit")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.orange)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }

                Button(action: confirmInvoice) {
                    Text("Confirm")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .padding()
        }
        .padding()
    }

    func confirmInvoice() {
        // Check if client already exists based on email
        if let existingClient = clients.first(where: { $0.email.lowercased() == invoice.client.email.lowercased() }) {
            // Use the existing client in the invoice
            invoice.client = existingClient
        } else {
            // Add the new client to the clients array
            clients.append(invoice.client)
        }

        // Add the invoice to the invoices array
        invoices.append(invoice)

        // Call the onConfirm closure to reset fields in CreateInvoiceView
        onConfirm?()

        // Dismiss back to the root view
        presentationMode.wrappedValue.dismiss() // Dismiss InvoiceDetailsView
        presentationMode.wrappedValue.dismiss() // Dismiss CreateInvoiceView
    }
}

struct InvoiceDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        InvoiceDetailsView(
            invoice: Invoice(
                client: Client(fullName: "John Doe", email: "john@example.com"),
                serviceDescription: "Web Design",
                totalAmount: 500.00
            ),
            clients: .constant([]),
            invoices: .constant([]),
            onConfirm: nil
        )
    }
}
