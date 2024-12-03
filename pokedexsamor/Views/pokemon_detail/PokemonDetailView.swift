import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel()
    let idOrName: String

    @State private var selectedTab = 0

    var body: some View {
        VStack {
            if viewModel.isLoading {
                ProgressView("Loading...")
                    .padding(.top, 50)
            } else if let pokemon = viewModel.pokemon {
                VStack(spacing: 16) {
                    // Header
                    HeaderView(pokemon: pokemon)

                    // Tabs
                    Picker("Tabs", selection: $selectedTab) {
                        Text("À propos").tag(0)
                        Text("Statistiques").tag(1)
                        Text("Évolutions").tag(2)
                    }
                    .pickerStyle(SegmentedPickerStyle())
                    .padding()

                    // Tab Content
                    TabView(selection: $selectedTab) {
                        AboutTabView(pokemon: pokemon)
                            .tag(0)
                        StatsTabView(pokemon: pokemon)
                            .tag(1)
                        EvolutionsTabView(viewModel: viewModel)
                            .tag(2)
                    }
                    .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                }
            } else if let error = viewModel.errorMessage {
                Text("Error: \(error)")
                    .foregroundColor(.red)
                    .padding(.top, 50)
            }
        }
        .onAppear {
            viewModel.fetchPokemonDetail(idOrName: idOrName)
        }
        .navigationTitle("Pokédex")
        .navigationBarTitleDisplayMode(.inline)
    }
}
