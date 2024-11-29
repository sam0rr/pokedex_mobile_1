import SwiftUI

struct LoginView: View {
    @StateObject private var viewModel = LoginViewModel()
    @State private var username = ""
    @State private var password = ""
    @State private var showError = false
    @State private var navigateToPokemonList = false

    var body: some View {
        NavigationView {
            ZStack {

                VStack {
                    Image("pokemon")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 250)

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

                    Button(action: {
                        let user = User(username: username, password: password)
                        viewModel.login(user: user) { success in
                            if success {
                                navigateToPokemonList = true
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
                    .background(viewModel.isLoading ? Color.gray : Color.red)
                    .foregroundColor(.white)
                    .cornerRadius(8)
                    .disabled(viewModel.isLoading)
                    .padding(.horizontal)

                    if let errorMessage = viewModel.errorMessage {
                        Text(errorMessage)
                            .foregroundColor(.white)
                            .padding()
                    }

                    Spacer()

                    NavigationLink(
                        destination: PokemonListView(),
                        isActive: $navigateToPokemonList,
                        label: { EmptyView() }
                    )
                }
                .padding()
            }
        }
    }
}
