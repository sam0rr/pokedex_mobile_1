import Foundation

class PokemonService {
    static let shared = PokemonService()

    private init() {}

    func fetchPokemonList(completion: @escaping (Result<[Pokemon], APIService.APIError>) -> Void) {
        let endpoint = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons?limit=151&lang=fr"
        print("Fetching Pokémon list from: \(endpoint)")
        APIService.shared.performRequest(
            url: endpoint,
            method: .get,
            completion: { (result: Result<PokemonResponse, APIService.APIError>) in
                switch result {
                case .success(let pokemonResponse):
                    completion(.success(pokemonResponse.results))
                case .failure(let error):
                    print("Error fetching Pokémon list: \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
        )
    }

    func fetchPokemonDetails(idOrName: String, completion: @escaping (Result<PokemonDetail, APIService.APIError>) -> Void) {
        let endpoint = "https://mapi.cegeplabs.qc.ca/pokedex/v2/pokemons/\(idOrName)?lang=fr"
        print("Fetching details for Pokémon with ID or Name: \(idOrName) from: \(endpoint)")
        
        APIService.shared.performRequest(
            url: endpoint,
            method: .get,
            completion: { (result: Result<PokemonDetail, APIService.APIError>) in
                switch result {
                case .success(let pokemonDetail):
                    completion(.success(pokemonDetail))
                case .failure(let error):
                    print("Error fetching details for Pokémon ID/Name \(idOrName): \(error.localizedDescription)")
                    completion(.failure(error))
                }
            }
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

}
