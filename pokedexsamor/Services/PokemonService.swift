import Foundation

class PokemonService {
    static let shared = PokemonService()

    private init() {}

    // Fetch Pokémon List
    func fetchPokemonList(completion: @escaping (Result<[Pokemon], APIService.APIError>) -> Void) {
        let endpoint = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons?limit=151&lang=fr"
        APIService.shared.performRequest(
            url: endpoint,
            method: .get,
            completion: { (result: Result<PokemonResponse, APIService.APIError>) in
                switch result {
                case .success(let pokemonResponse):
                    completion(.success(pokemonResponse.results))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        )
    }

    // Fetch Pokémon Details
    func fetchPokemonDetails(idOrName: String, completion: @escaping (Result<PokemonDetail, APIService.APIError>) -> Void) {
        let endpoint = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons/\(idOrName)?lang=fr"
        APIService.shared.performRequest(
            url: endpoint,
            method: .get,
            completion: completion
        )
    }
}
