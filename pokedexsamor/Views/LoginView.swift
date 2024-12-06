import SwiftUI

struct LoginView: View {
    @Binding var isLoggedIn: Bool
    @StateObject private var viewModel = LoginViewModel()
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false

    var body: some View {
        VStack {
            Image("pokemon")
                .resizable()
                .scaledToFit()
                .frame(width: 350, height: 300)

            Spacer()

            VStack(spacing: 16) {
                TextField("Nom d'utilisateur", text: $username)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)

                SecureField("Mot de passe", text: $password)
                    .padding()
                    .background(Color(.systemGray6))
                    .cornerRadius(8)
                    .autocapitalization(.none)
                    .disableAutocorrection(true)
            }
            .padding(.horizontal)
            .padding(.vertical)

            Button(action: {
                let user = User(username: username, password: password)
                viewModel.login(user: user) { success in
                    if success {
                        isLoggedIn = true
                    } else {
                        showError = true
                    }
                }
            }) {
                if viewModel.isLoading {
                    ProgressView()
                        .frame(maxWidth: .infinity)
                        .padding()
                } else {
                    Text("Se connecter")
                        .frame(maxWidth: .infinity)
                        .padding()
                }
            }
            .background(Color.red)
            .foregroundColor(.white)
            .cornerRadius(8)
            .disabled(viewModel.isLoading)
            .padding(.horizontal)

            Spacer()

            if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.white)
                    .padding()
            }
        }
    }
}
