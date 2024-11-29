import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    VStack {
                        ProgressView()
                        Text("Chargement des Pokémon...")
                            .padding(.top, 8)
                    }
                } else if let errorMessage = viewModel.errorMessage {
                    Text("Erreur : \(errorMessage)")
                        .foregroundColor(.red)
                        .padding()
                } else {
                    TextField("Rechercher un Pokémon", text: $viewModel.searchQuery)
                        .padding()
                        .background(Color(.systemGray6))
                        .cornerRadius(8)
                        .padding(.horizontal)

                    if !viewModel.selectedTypes.isEmpty {
                        Text("Filtres actifs : \(viewModel.selectedTypes.joined(separator: ", "))")
                            .padding()
                    }

                    List(viewModel.filteredPokemon) { pokemon in
                        NavigationLink(destination: PokemonDetailView(idOrName: "\(pokemon.id)")) {
                            PokemonRow(pokemon: pokemon)
                        }
                    }
                }
            }
            .navigationTitle("Pokédex")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {
                        viewModel.toggleFilterSheet()
                    }) {
                        Image(systemName: "line.horizontal.3.decrease.circle")
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
