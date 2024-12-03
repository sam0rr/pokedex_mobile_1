import Foundation

class APIService {
    
    enum APIError: Error, LocalizedError {
        case invalidURL
        case networkError(Error)
        case serverError
        case authenticationFailed
        case noResponse
        case noData
        case decodingError
        case serializationError

        var errorDescription: String? {
            switch self {
            case .invalidURL:
                return "URL invalide."
            case .networkError(let error):
                return "Erreur réseau : \(error.localizedDescription)"
            case .serverError:
                return "Erreur du serveur."
            case .authenticationFailed:
                return "Échec de l'authentification. Vérifiez vos informations."
            case .noResponse:
                return "Aucune réponse du serveur."
            case .noData:
                return "Aucune donnée reçue."
            case .decodingError:
                return "Erreur de décodage des données."
            case .serializationError:
                return "Erreur lors de la sérialisation des paramètres."
            }
        }

    }
    
    static let shared = APIService()

    private init() {}

    func performRequest<T: Decodable>(
        url: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        guard let endpoint = URL(string: url) else {
            logError("Invalid URL: \(url)")
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let parameters = parameters, method == .post {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = jsonData
            } catch {
                completion(.failure(.serializationError))
                return
            }
        }

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }

            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError))
                return
            }

            guard let data = data else {
                completion(.failure(.noData))
                return
            }

            do {
                let decodedData = try JSONDecoder().decode(T.self, from: data)
                completion(.success(decodedData))
            } catch let DecodingError.dataCorrupted(context) {
                print("Data corrupted: \(context.debugDescription)")
                completion(.failure(.decodingError))
            } catch let DecodingError.keyNotFound(key, context) {
                print("Key '\(key.stringValue)' not found: \(context.debugDescription)")
                completion(.failure(.decodingError))
            } catch let DecodingError.typeMismatch(type, context) {
                print("Type mismatch for type \(type): \(context.debugDescription)")
                completion(.failure(.decodingError))
            } catch let DecodingError.valueNotFound(value, context) {
                print("Value '\(value)' not found: \(context.debugDescription)")
                completion(.failure(.decodingError))
            } catch {
                print("Decoding error: \(error)")
                completion(.failure(.decodingError))
            }
        }

        task.resume()
    }

    private func performRequest(
        url: String,
        method: HTTPMethod,
        parameters: [String: Any]? = nil,
        completion: @escaping (Result<Void, APIError>) -> Void
    ) {
        guard let endpoint = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }

        var request = URLRequest(url: endpoint)
        request.httpMethod = method.rawValue
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        if let parameters = parameters, method == .post {
            do {
                let jsonData = try JSONSerialization.data(withJSONObject: parameters, options: [])
                request.httpBody = jsonData
            } catch {
                completion(.failure(.serializationError))
                return
            }
        }

        let task = URLSession.shared.dataTask(with: request) { _, response, error in
            if let error = error {
                completion(.failure(.networkError(error)))
                return
            }

            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(.noResponse))
                return
            }

            if !(200...299).contains(httpResponse.statusCode) {
                completion(.failure(.serverError))
                return
            }

            completion(.success(()))
        }

        task.resume()
    }

    func post(
        to url: String,
        parameters: [String: Any],
        completion: @escaping (Result<Void, APIError>) -> Void
    ) {
        performRequest(url: url, method: .post, parameters: parameters, completion: completion)
    }

    func post<T: Decodable>(
        to url: String,
        parameters: [String: Any],
        completion: @escaping (Result<T, APIError>) -> Void
    ) {
        performRequest(url: url, method: .post, parameters: parameters, completion: completion)
    }
}

    private func logInfo(_ message: String) {
        print("ℹ️ \(message)")
    }

    private func logError(_ message: String) {
        print("❌ \(message)")
    }

    enum HTTPMethod: String {
        case get = "GET"
        case post = "POST"
    }

    
