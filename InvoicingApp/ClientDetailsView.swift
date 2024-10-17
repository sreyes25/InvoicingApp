import SwiftUI

struct ClientDetailsView: View {
    var client: Client

    var body: some View {
        VStack(alignment: .leading, spacing: 20) {
            Text("Client Details")
                .font(.largeTitle)
                .padding()

            Text("Name: \(client.fullName)")
                .font(.title2)
            Text("Email: \(client.email)")
                .font(.title3)
                .foregroundColor(.gray)

            Spacer()
        }
        .padding()
        .navigationBarTitle("Client", displayMode: .inline)
    }
}

struct ClientDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        ClientDetailsView(client: Client(fullName: "John Doe", email: "john@example.com"))
    }
}
