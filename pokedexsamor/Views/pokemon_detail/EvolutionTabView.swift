import SwiftUI

struct EvolutionsTabView: View {
    @ObservedObject var viewModel: PokemonDetailViewModel
    let typeColor: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if viewModel.isFetchingEvolutions {
                    ProgressView("Loading evolutions...")
                        .padding(.top, 20)
                } else if let errorMessage = viewModel.evolutionErrorMessage {
                    Text("Error: \(errorMessage)")
                        .foregroundColor(.red)
                } else if viewModel.evolutionDetails.isEmpty {
                    Text("Pas d'évolutions disponibles.")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                } else {
                    Text("Évolutions")
                        .font(.headline)
                        .foregroundColor(typeColor)
                        .padding(.top, 12)
                        .padding(.bottom, 8)

                    LazyVStack(spacing: 12) {
                        ForEach(viewModel.evolutionDetails) { evolution in
                            PokemonRowNavigationView(pokemon: evolution)
                        }
                    }
                }
            }
            .padding()
        }
    }
}
