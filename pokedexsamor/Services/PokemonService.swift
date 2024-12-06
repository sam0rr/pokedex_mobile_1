import Foundation

class PokemonService {
    static let shared = PokemonService()
    private init() {}

    private let baseURL = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons"
    private let limit = 150

    func fetchPokemonList(completion: @escaping (Result<[Pokemon], APIService.APIError>) -> Void) {
        fetchAllBatches(offset: 0, accumulatedPokemon: [], completion: completion)
    }

    func fetchPokemonDetails(idOrName: String, completion: @escaping (Result<PokemonDetail, APIService.APIError>) -> Void) {
        let endpoint = "\(baseURL)/\(idOrName)?lang=fr"
        print("Fetching details for Pokémon with ID or Name: \(idOrName) from: \(endpoint)")

        APIService.shared.performRequest(
            url: endpoint,
            method: .get,
            completion: completion
        )
    }

    func fetchEvolution(
        evolutionNames: [String],
        completion: @escaping (Result<[Pokemon], APIService.APIError>) -> Void
    ) {
        var fetchedPokemon: [Pokemon] = []
        let group = DispatchGroup()
        var fetchError: APIService.APIError?

        for name in evolutionNames {
            group.enter()
            fetchPokemonDetails(idOrName: name) { result in
                switch result {
                case .success(let pokemonDetail):
                    let pokemon = Pokemon(
                        id: pokemonDetail.id,
                        name: pokemonDetail.name,
                        isFavorite: pokemonDetail.isFavorite,
                        types: pokemonDetail.types
                    )
                    fetchedPokemon.append(pokemon)
                case .failure(let error):
                    fetchError = error
                }
                group.leave()
            }
        }

        group.notify(queue: .main) {
            if let error = fetchError {
                completion(.failure(error))
            } else {
                completion(.success(fetchedPokemon))
            }
        }
    }

    private func fetchAllBatches(
        offset: Int,
        accumulatedPokemon: [Pokemon],
        completion: @escaping (Result<[Pokemon], APIService.APIError>) -> Void
    ) {
        let endpoint = "\(baseURL)?limit=\(limit)&offset=\(offset)&lang=fr"
        print("Fetching Pokémon batch from: \(endpoint)")

        APIService.shared.performRequest(url: endpoint, method: .get) { (result: Result<PokemonResponse, APIService.APIError>) in
            switch result {
            case .success(let response):
                let allPokemon = accumulatedPokemon + response.results
                if response.results.count < self.limit {
                    completion(.success(allPokemon))
                } else {
                    self.fetchAllBatches(offset: offset + self.limit, accumulatedPokemon: allPokemon, completion: completion)
                }
            case .failure(let error):
                completion(.failure(error))
            }
        }
    }
}
