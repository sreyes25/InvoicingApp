// ClientsView.swift

import SwiftUI

struct ClientsView: View {
    @Binding var clients: [Client]
    @State private var showAddClientForm = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(clients) { client in
                    NavigationLink(destination: ClientDetailsView(client: client)) {
                        VStack(alignment: .leading) {
                            Text(client.fullName)
                                .font(.headline)
                            Text(client.email)
                                .font(.subheadline)
                                .foregroundColor(.gray)
                        }
                    }
                }
                .onDelete(perform: deleteClient)
            }
            .navigationBarTitle("Clients")
            .navigationBarItems(trailing:
                Button(action: {
                    showAddClientForm.toggle()
                }) {
                    Image(systemName: "plus")
                }
            )
            .sheet(isPresented: $showAddClientForm) {
                AddClientView(clients: $clients)
            }
        }
    }
    
    func deleteClient(at offsets: IndexSet) {
        clients.remove(atOffsets: offsets)
    }
}

struct ClientsView_Previews: PreviewProvider {
    static var previews: some View {
        ClientsView(clients: .constant([
            Client(fullName: "John Doe", email: "john@example.com"),
            Client(fullName: "Jane Smith", email: "jane@example.com")
        ]))
    }
}
