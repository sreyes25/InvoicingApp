import SwiftUI

let currencyFormatter: NumberFormatter = {
    let formatter = NumberFormatter()
    formatter.numberStyle = .currency
    formatter.maximumFractionDigits = 2
    formatter.minimumFractionDigits = 2
    formatter.locale = Locale.current
    return formatter
}()

struct CreateInvoiceView: View {
    @Binding var clients: [Client]
    @Binding var invoices: [Invoice]

    @State private var clientName: String = ""
    @State private var clientEmail: String = ""
    @State private var serviceDescription: String = ""
    @State private var unformattedTotalAmount: String = ""
    @State private var existingClientSelected: Client? = nil
    @State private var draftInvoice: Invoice? = nil
    @State private var path = NavigationPath()

    var body: some View {
        NavigationStack(path: $path) {
            Form {
                // Client Information Section
                Section(header: Text("Client Information")) {
                    Picker("Choose Client", selection: $existingClientSelected) {
                        Text("New Client").tag(nil as Client?)
                        ForEach(clients) { client in
                            HStack {
                                Text(client.fullName)
                                Text("(\(client.email))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                            .tag(client as Client?)
                        }
                    }
                    .pickerStyle(MenuPickerStyle())

                    if let selectedClient = existingClientSelected {
                        // Display selected client's name and email
                        Text("\(selectedClient.fullName)")
                        Text("\(selectedClient.email)")
                    } else {
                        TextField("Client Name", text: $clientName)
                        TextField("Client Email", text: $clientEmail)
                            .keyboardType(.emailAddress)
                            .autocapitalization(.none)
                    }
                }

                // Service Details Section
                Section(header: Text("Service Details")) {
                    TextField("Service Description", text: $serviceDescription)
                }

                // Total Amount Section
                Section(header: Text("Total Amount")) {
                    TextField("Total Amount", text: $unformattedTotalAmount)
                        .keyboardType(.decimalPad)
                        .onChange(of: unformattedTotalAmount) { newValue, _ in
                            formatTotalAmountInput(newValue)
                        }
                }

                // Submit Button
                Button(action: submitInvoice) {
                    Text("Submit Invoice")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Create Invoice", displayMode: .inline)
            .navigationDestination(for: Invoice.self) { invoice in
                InvoiceDetailsView(
                    invoice: invoice,
                    clients: $clients,
                    invoices: $invoices,
                    onConfirm: {
                        // Reset fields after confirmation
                        clientName = ""
                        clientEmail = ""
                        serviceDescription = ""
                        unformattedTotalAmount = ""
                        existingClientSelected = nil
                        draftInvoice = nil
                    }
                )
            }
        }
    }

    func formatTotalAmountInput(_ value: String) {
        // Remove any non-digit characters
        let digits = value.components(separatedBy: CharacterSet.decimalDigits.inverted).joined()

        // Convert the string to a decimal number
        if let number = Decimal(string: digits) {
            // Divide by 100 to get the correct currency value
            let amount = number / 100

            // Format the amount using the currency formatter
            if let formattedAmount = currencyFormatter.string(from: amount as NSNumber) {
                unformattedTotalAmount = formattedAmount
            }
        } else {
            // If conversion fails, reset the field
            unformattedTotalAmount = ""
        }
    }

    func submitInvoice() {
        // Input validation
        guard !serviceDescription.isEmpty, !unformattedTotalAmount.isEmpty else {
            // Handle empty fields (you can show an alert here)
            return
        }

        // Remove currency symbols and commas to get the numeric value
        let amountString = unformattedTotalAmount.components(separatedBy: CharacterSet(charactersIn: "$,")).joined()
        let amount = Double(amountString) ?? 0.0

        var invoiceClient: Client

        if let existingClient = existingClientSelected {
            invoiceClient = existingClient
        } else {
            // Ensure client name and email are not empty
            guard !clientName.isEmpty, !clientEmail.isEmpty else {
                // Handle empty client name or email (you can show an alert here)
                return
            }
            // Create a new client
            invoiceClient = Client(fullName: clientName, email: clientEmail)
        }

        // Create a draft invoice
        draftInvoice = Invoice(
            client: invoiceClient,
            serviceDescription: serviceDescription,
            totalAmount: amount
        )

        // Navigate to InvoiceDetailsView by appending the draft invoice to the path
        if let draftInvoice = draftInvoice {
            path.append(draftInvoice)
        }
    }
}

struct CreateInvoiceView_Previews: PreviewProvider {
    static var previews: some View {
        CreateInvoiceView(
            clients: .constant([
                Client(fullName: "John Doe", email: "john@example.com"),
                Client(fullName: "Jane Smith", email: "jane@example.com")
            ]),
            invoices: .constant([])
        )
    }
}
