import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: PokemonDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    @Published var evolutionDetails: [Pokemon] = []
    @Published var isFetchingEvolutions: Bool = false
    @Published var evolutionErrorMessage: String? = nil


    func fetchPokemonDetail(idOrName: String) {
        isLoading = true
        errorMessage = nil

        PokemonService.shared.fetchPokemonDetails(idOrName: idOrName) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let detail):
                    self?.pokemon = detail
                    self?.fetchEvolutions(for: detail.evolutions)
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error fetching Pokémon: \(error.localizedDescription)")
                }
            }
        }
    }

    private func fetchEvolutions(for evolutionNames: [String]) {
        guard !evolutionNames.isEmpty else { return }

        isFetchingEvolutions = true
        evolutionErrorMessage = nil

        PokemonService.shared.fetchEvolution(evolutionNames: evolutionNames) { [weak self] result in
            DispatchQueue.main.async {
                self?.isFetchingEvolutions = false
                switch result {
                case .success(let evolutions):
                    self?.evolutionDetails = evolutions.filter { evolution in
                        guard let currentPokemon = self?.pokemon else { return true }
                        return evolution.name.lowercased() != currentPokemon.name.lowercased()
                    }
                case .failure(let error):
                    self?.evolutionErrorMessage = error.localizedDescription
                    print("❌ Error fetching evolutions: \(error.localizedDescription)")
                }
            }
        }
    }
}
