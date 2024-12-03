import Foundation

class PokemonService {
    static let shared = PokemonService()

    private init() {}

    func fetchPokemonList(completion: @escaping (Result<[Pokemon], APIService.APIError>) -> Void) {
        let endpoint = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons?limit=151&lang=fr"
        print("Fetching Pokémon list from: \(endpoint)") // Debug log
        APIService.shared.performRequest(
            url: endpoint,
            method: .get,
            completion: { (result: Result<PokemonResponse, APIService.APIError>) in
                switch result {
                case .success(let pokemonResponse):
                    print("Successfully fetched Pokémon list: \(pokemonResponse.results.count) Pokémon found.") // Debug log
                    completion(.success(pokemonResponse.results))
                case .failure(let error):
                    print("Error fetching Pokémon list: \(error.localizedDescription)") // Debug log
                    completion(.failure(error))
                }
            }
        )
    }

    func fetchPokemonDetails(idOrName: String, completion: @escaping (Result<PokemonDetail, APIService.APIError>) -> Void) {
        let endpoint = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons/\(idOrName)?lang=fr"
        print("Fetching details for Pokémon with ID or Name: \(idOrName) from: \(endpoint)") // Debug log
        
        APIService.shared.performRequest(
            url: endpoint,
            method: .get,
            completion: { (result: Result<PokemonDetail, APIService.APIError>) in
                switch result {
                case .success(let pokemonDetail):
                    completion(.success(pokemonDetail))
                case .failure(let error):
                    print("Error fetching details for Pokémon ID/Name \(idOrName): \(error.localizedDescription)") // Debug error
                    completion(.failure(error))
                }
            }
        )
    }

}
