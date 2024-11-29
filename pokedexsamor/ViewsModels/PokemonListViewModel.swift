import Foundation

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var searchQuery: String = ""
    @Published var selectedTypes: Set<String> = []
    @Published var isFilterSheetPresented = false
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false

    var filteredPokemon: [Pokemon] {
        var filtered = pokemonList

        if !searchQuery.isEmpty {
            filtered = filtered.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }

        if !selectedTypes.isEmpty {
            filtered = filtered.filter { !Set($0.types).isDisjoint(with: selectedTypes) }
        }

        return filtered
    }

    func fetchPokemon() {
        isLoading = true
        errorMessage = nil

        PokemonService.shared.fetchPokemonList { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false
                switch result {
                case .success(let pokemon):
                    self?.pokemonList = pokemon
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("Error fetching Pokémon: \(error.localizedDescription)")
                }
            }
        }
    }

    func toggleFilterSheet() {
        isFilterSheetPresented.toggle()
    }
}

