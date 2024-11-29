class AuthService {
    static let shared = AuthService()
    private let baseURL = "https://mapi.cegeplabs.qc.ca/auth/v1/"

    private init() {}

    func login(username: String, password: String, completion: @escaping (Result<Bool, APIService.APIError>) -> Void) {
        let endpoint = "\(baseURL)login"
        let parameters: [String: Any] = [
            "username": username,
            "password": password
        ]

        APIService.shared.post(to: endpoint, parameters: parameters) { result in
            switch result {
            case .success:
                print("✅ Authentification réussie (Code 200)")
                completion(.success(true))
            case .failure(let error):
                print("❌ Authentification échouée : \(error.localizedDescription)")
                completion(.failure(error))
            }
        }
    }
}
