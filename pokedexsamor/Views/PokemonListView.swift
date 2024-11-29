import SwiftUI

struct PokemonListView: View {
    @StateObject private var viewModel = PokemonListViewModel()

    var body: some View {
        NavigationView {
            VStack {
                // UI for Pokémon list, filters, search, etc.
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
