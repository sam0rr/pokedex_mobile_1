import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search Bar Section
                VStack(alignment: .leading, spacing: 8) {
                    Text("Rechercher un Pokémon par nom")
                        .font(.system(size: 14, weight: .bold))
                        .foregroundColor(.gray)
                        .padding(.leading, 16)

                    PokemonSearchView(searchText: $viewModel.searchQuery)
                        .padding(.horizontal, 16)
                }
                .padding(.bottom, 8)
                .background(Color(.systemBackground))
                .zIndex(1)

                // Pokémon List Section
                if viewModel.isLoading {
                    ProgressView("Loading Pokémon...")
                        .padding()
                } else if !viewModel.filteredPokemon.isEmpty {
                    ScrollView {
                        LazyVStack(spacing: 16) {
                            ForEach(viewModel.filteredPokemon, id: \.id) { pokemon in
                                PokemonRow(pokemon: pokemon)
                            }
                        }
                        .padding(.horizontal, 16)
                        .padding(.top, 8)
                    }
                } else {
                    Text("Aucun Pokémon trouvé.")
                        .foregroundColor(.secondary)
                        .padding()
                }
            }
            .background(Color(.systemBackground))
            .navigationTitle("Pokédex")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.toggleFilterSheet()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title2)
                            .foregroundColor(.black) // Toolbar filter button in black
                    }
                }
            }
            .sheet(isPresented: $viewModel.isFilterSheetPresented) {
                TypeFilterSheet(selectedTypes: $viewModel.selectedTypes)
            }
            .onAppear {
                viewModel.fetchPokemon()
            }
        }
    }
}
