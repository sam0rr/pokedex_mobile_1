import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                if viewModel.isLoading {
                    ProgressView("Loading Pokemon...")
                        .padding()
                } else if !viewModel.filteredPokemon.isEmpty {
                    List(viewModel.filteredPokemon, id: \.id) { pokemon in
                        PokemonRow(pokemon: pokemon)
                    }
                    .listStyle(PlainListStyle())
                } else {
                    Text("No Pokemon found.")
                        .foregroundColor(.secondary)
                        .padding()
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
