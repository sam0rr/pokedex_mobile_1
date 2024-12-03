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

        // Filter by search query
        if !searchQuery.isEmpty {
            filtered = filtered.filter { $0.name.lowercased().contains(searchQuery.lowercased()) }
        }

        // Filter by selected types
        if !selectedTypes.isEmpty {
            let lowercasedTypes = selectedTypes.map { $0.lowercased() }
            filtered = filtered.filter { !Set($0.types.map { $0.lowercased() }).isDisjoint(with: lowercasedTypes) }
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
                    self?.pokemonList = pokemon.sorted(by: { $0.id < $1.id })
                    print("Success fetching pokemons")
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                    print("❌ Error fetching Pokémon: \(error.localizedDescription)")
                }
            }
        }
    }

    /// Toggles the visibility of the filter sheet
    func toggleFilterSheet() {
        isFilterSheetPresented.toggle()
    }
}
