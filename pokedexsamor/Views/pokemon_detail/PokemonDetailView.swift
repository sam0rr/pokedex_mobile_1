import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel()
    let idOrName: String

    @State private var selectedTab = 0

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Color(viewModel.pokemon?.types.first?.lowercased() ?? "normal")
                    .lighter(by: 0.15)
                    .ignoresSafeArea()

                VStack {
                    if viewModel.isLoading {
                        ProgressView("Chargement...")
                            .padding(.top, 50)
                    } else if let pokemon = viewModel.pokemon {
                        VStack(spacing: 0) {
                            HeaderView(pokemon: pokemon)
                                .padding(.top, 40)

                            HStack(spacing: 0) {
                                TabButton(
                                    title: "À propos",
                                    isSelected: selectedTab == 0,
                                    action: { selectedTab = 0 }
                                )
                                TabButton(
                                    title: "Statistiques",
                                    isSelected: selectedTab == 1,
                                    action: { selectedTab = 1 }
                                )
                                TabButton(
                                    title: "Évolutions",
                                    isSelected: selectedTab == 2,
                                    action: { selectedTab = 2 }
                                )
                            }
                            .frame(maxWidth: .infinity)

                            TabView(selection: $selectedTab) {
                                AboutTabView(
                                    pokemon: pokemon,
                                    typeColor: Color(pokemon.types.first?.lowercased() ?? "normal")
                                )
                                .tag(0)
                                
                                StatsTabView(
                                    pokemon: pokemon,
                                    typeColor: Color(pokemon.types.first?.lowercased() ?? "normal")
                                )
                                .tag(1)
                                
                                EvolutionsTabView(
                                    viewModel: viewModel,
                                    typeColor: Color(pokemon.types.first?.lowercased() ?? "normal")
                                )
                                .tag(2)
                            }
                            .background(Color.white)
                            .cornerRadius(30.0)
                            .tabViewStyle(PageTabViewStyle(indexDisplayMode: .never))
                            .frame(height: geometry.size.height - 300)
                        }
                    } else if let error = viewModel.errorMessage {
                        Text("Error: \(error)")
                            .foregroundColor(.red)
                            .padding(.top, 50)
                    }
                }
            }
        }
        .onAppear {
            viewModel.fetchPokemonDetail(idOrName: idOrName)
        }
        .navigationTitle("Pokédex")
        .navigationBarTitleDisplayMode(.inline)
    }
}
