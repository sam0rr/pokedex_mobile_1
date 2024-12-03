import Foundation

class PokemonDetailViewModel: ObservableObject {
    @Published var pokemon: PokemonDetail?
    @Published var isLoading: Bool = false
    @Published var errorMessage: String? = nil

    func fetchPokemonDetail(idOrName: String) {
        isLoading = true
        errorMessage = nil

        PokemonService.shared.fetchPokemonDetails(idOrName: idOrName) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let detail):
                    self?.pokemon = detail
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error fetching Pokémon: \(error.localizedDescription)")
                }
            }
        }
    }
}
