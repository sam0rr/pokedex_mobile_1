import Foundation
import Combine

class PokemonListViewModel: ObservableObject {
    @Published var pokemonList: [Pokemon] = []
    @Published var searchQuery: String = "" {
        didSet { updateDisplayedPokemon() }
    }
    @Published var selectedTypes: Set<String> = [] {
        didSet { updateDisplayedPokemon() }
    }
    @Published var isFilterSheetPresented = false
    @Published var errorMessage: String? = nil
    @Published var isLoading: Bool = false
    @Published var scannedPokemons: [String] = [] {
        didSet { updateDisplayedPokemon() }
    }
    @Published var isScannerActive: Bool = false

    @Published var scannedPokemonRows: [Pokemon] = []
    @Published var filteredPokemonRows: [Pokemon] = []

    var displayedPokemon: [Pokemon] {
        scannedPokemonRows + filteredPokemonRows
    }

    init() {
        updateDisplayedPokemon()
    }

    private func updateDisplayedPokemon() {
        var uniquePokemonIDs = Set<Int>()

        scannedPokemonRows = pokemonList.filter { pokemon in
            let isScanned = scannedPokemons.contains(pokemon.name.lowercased()) || scannedPokemons.contains(String(pokemon.id))
            if isScanned {
                uniquePokemonIDs.insert(pokemon.id)
            }
            return isScanned
        }

        filteredPokemonRows = pokemonList.filter { pokemon in
            !uniquePokemonIDs.contains(pokemon.id) &&
            (searchQuery.isEmpty || pokemon.name.lowercased().contains(searchQuery.lowercased())) &&
            (selectedTypes.isEmpty || !Set(pokemon.types.map { $0.lowercased() }).isDisjoint(with: selectedTypes.map { $0.lowercased() }))
        }
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
                    self?.updateDisplayedPokemon()
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }

    func addScannedPokemons(_ codes: [String]) {
        for code in codes {
            if !scannedPokemons.contains(code.lowercased()) {
                scannedPokemons.append(code.lowercased())
            }
        }
    }

    func resetScannedPokemons() {
        scannedPokemons.removeAll()
    }

    func toggleScanner() {
        isScannerActive.toggle()
    }
}


