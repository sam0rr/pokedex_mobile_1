import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel()
    let idOrName: String

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
            } else if let pokemon = viewModel.pokemon {
                Text("Pokémon: \(pokemon.name)")
                    .font(.title)
                Text("Description: \(pokemon.description)")
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
            }
        }
        .onAppear {
            print("Navigating to Detail View with ID: \(idOrName)") // Debug log
            viewModel.fetchPokemonDetail(idOrName: idOrName)
        }
    }
}
