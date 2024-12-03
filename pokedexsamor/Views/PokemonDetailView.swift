import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel()
    let idOrName: String

    var body: some View {
        Group {
            if viewModel.isLoading {
                VStack {
                    ProgressView()
                    Text("Loading Pokemons...")
                        .padding(.top, 8)
                }
            } else if let pokemon = viewModel.pokemon {
                ScrollView {
                    VStack(spacing: 20) {
                        // Pokémon Image
                        ZStack {
                            AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
                                if let image = phase.image {
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                } else if phase.error != nil {
                                    Image(systemName: "exclamationmark.triangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.red)
                                } else {
                                    ProgressView()
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            // General Info
                            Text("#\(String(format: "%03d", pokemon.id)) \(pokemon.name)")
                                .font(.title)
                                .bold()
                            Text(pokemon.types.joined(separator: ", "))
                                .font(.headline)
                                .foregroundColor(.secondary)

                            // Tabs for detailed information
                            TabView {
                                // About Tab
                                VStack(alignment: .leading) {
                                    Text("À propos")
                                        .font(.title2)
                                        .bold()
                                    Text(pokemon.description)
                                        .font(.body)

                                    Divider()

                                    HStack {
                                        Text("Espèce : \(pokemon.speciesName)")
                                        Spacer()
                                        Text("Taille : \(Double(pokemon.height) / 10) m")
                                    }
                                    .font(.subheadline)

                                    HStack {
                                        Text("Poids : \(Double(pokemon.weight) / 10) kg")
                                        Spacer()
                                        VStack(alignment: .leading) {
                                            Text("Faiblesses :")
                                            ForEach(pokemon.weaknesses, id: \.self) { weakness in
                                                Text(weakness)
                                                    .font(.caption)
                                                    .padding(5)
                                                    .background(Color.gray.opacity(0.2))
                                                    .cornerRadius(5)
                                            }
                                        }
                                    }
                                }
                                .padding()
                                .tabItem {
                                    Label("À propos", systemImage: "info.circle")
                                }

                                // Stats Tab
                                VStack(alignment: .leading) {
                                    Text("Statistiques de base")
                                        .font(.title2)
                                        .bold()
                                    let stats = pokemon.stats // Use stats from `PokemonDetail`
                                    ForEach(stats) { stat in
                                        HStack {
                                            Text(stat.name.capitalized)
                                                .frame(width: 100, alignment: .leading)
                                            ProgressView(value: Double(stat.value) / 100.0)
                                                .progressViewStyle(LinearProgressViewStyle(tint: .blue))
                                            Text("\(stat.value)")
                                                .frame(width: 30, alignment: .trailing)
                                        }
                                    }
                                }
                                .padding()
                                .tabItem {
                                    Label("Statistiques", systemImage: "chart.bar.fill")
                                }

                                // Evolution Tab
                                VStack {
                                    Text("Évolutions")
                                        .font(.title2)
                                        .bold()
                                    ForEach(pokemon.evolutions, id: \.self) { evolution in
                                        NavigationLink(destination: PokemonDetailView(idOrName: evolution)) {
                                            HStack {
                                                AsyncImage(url: URL(string: "https://mapi.cegeplabs.qc.ca/pokedex/v2/images/\(evolution.lowercased()).png")) { phase in
                                                    if let image = phase.image {
                                                        image.resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                    } else if phase.error != nil {
                                                        Image(systemName: "exclamationmark.triangle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                            .foregroundColor(.red)
                                                    } else {
                                                        ProgressView()
                                                    }
                                                }
                                                Text(evolution.capitalized)
                                            }
                                        }
                                        .padding()
                                    }
                                }
                                .padding()
                                .tabItem {
                                    Label("Évolutions", systemImage: "arrow.up.right.circle")
                                }
                            }
                        }
                        .padding()
                    }
                }
            } else if let errorMessage = viewModel.errorMessage {
                Text(errorMessage)
                    .foregroundColor(.red)
                    .padding()
            }
        }
        .onAppear {
            viewModel.fetchPokemonDetail(idOrName: idOrName)
        }
    }
}
