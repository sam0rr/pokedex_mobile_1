import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView { // NavigationView wraps all content
            VStack(spacing: 0) {
                // Title Section
                Text("Pokédex")
                    .font(.system(size: 42, weight: .bold)) // Customize as needed
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding(.horizontal, 16)
                    .padding(.top, 16)
                    .padding(.bottom, 16)
                    .background(Color(.systemBackground)) // Same background color for consistency
                                
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
                } else {
                    ScrollView {
                        if !viewModel.filteredPokemon.isEmpty {
                            LazyVStack(spacing: 16) {
                                ForEach(viewModel.filteredPokemon, id: \.id) { pokemon in
                                    PokemonRowNavigationView(pokemon: pokemon)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.top, 8)
                        } else {
                            VStack {
                                Spacer()
                                Text("Aucun Pokémon trouvé.")
                                    .foregroundColor(.secondary)
                                    .padding()
                                Spacer()
                            }
                        }
                    }
                }
            }
            .background(Color(.systemBackground))
            .navigationBarTitleDisplayMode(.inline) // Ensure title stays consistent
            .navigationBarBackButtonHidden(true) // Hide back button
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.toggleFilterSheet()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
                            .font(.title2)
                            .foregroundColor(.black)
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
        .navigationBarBackButtonHidden(true) // Ensure it's applied to the whole view
    }
}
