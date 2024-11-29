//
//  PokemonDetailViewModel.swift
//  pokedexsamor
//
//  Created by Samuel Arseneault on 2024-11-29.
//

import Foundation

class PokemonDetailViewModel: ObservableObject {
    // MARK: - Published Properties
    @Published var pokemon: PokemonDetail? // Stores detailed Pokémon data
    @Published var isLoading: Bool = false // Indicates loading state
    @Published var errorMessage: String? = nil // Stores error messages for UI

    // MARK: - Fetch Pokémon Detail
    func fetchPokemonDetail(idOrName: String) {
        isLoading = true
        errorMessage = nil

        // Use the PokemonService to fetch details
        PokemonService.shared.fetchPokemonDetails(idOrName: idOrName) { [weak self] result in
            DispatchQueue.main.async {
                self?.isLoading = false

                switch result {
                case .success(let detail):
                    self?.pokemon = detail
                case .failure(let error):
                    self?.errorMessage = error.localizedDescription
                }
            }
        }
    }
}
