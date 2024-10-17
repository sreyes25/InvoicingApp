// AddClientView.swift

import SwiftUI

struct AddClientView: View {
    @Environment(\.presentationMode) var presentationMode
    @Binding var clients: [Client]
    
    @State private var fullName: String = ""
    @State private var email: String = ""
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Client Information")) {
                    TextField("Full Name", text: $fullName)
                    TextField("Email", text: $email)
                        .keyboardType(.emailAddress)
                }
                
                Button(action: saveClient) {
                    Text("Save Client")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
            }
            .navigationBarTitle("Add Client", displayMode: .inline)
            .navigationBarItems(trailing:
                Button("Cancel") {
                    presentationMode.wrappedValue.dismiss()
                }
            )
        }
    }
    
    func saveClient() {
        guard !fullName.isEmpty, !email.isEmpty else {
            // Handle empty fields
            return
        }
        
        let newClient = Client(fullName: fullName, email: email)
        clients.append(newClient)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddClientView_Previews: PreviewProvider {
    static var previews: some View {
        AddClientView(clients: .constant([]))
    }
}
