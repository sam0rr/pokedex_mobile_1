import Foundation

class LoginViewModel: ObservableObject {
    @Published var isAuthenticated: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?

    func login(user: User, completion: @escaping (Bool) -> Void) {
        errorMessage = nil
        isLoading = true

        guard !user.username.isEmpty, !user.password.isEmpty else {
            errorMessage = "Nom d'utilisateur et mot de passe sont requis."
            isLoading = false
            completion(false)
            return
        }

        let adjustedPassword = user.password + "2024"

        AuthService.shared.login(username: user.username, password: adjustedPassword) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success:
                    self?.isAuthenticated = true
                    completion(true)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    completion(false)
                }
            }
        }
    }
}
