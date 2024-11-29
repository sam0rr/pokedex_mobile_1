import SwiftUI

struct PokemonDetailView: View {
    @StateObject private var viewModel = PokemonDetailViewModel()
    let idOrName: String

    var body: some View {
        Group {
            if viewModel.isLoading {
    
            } else if let pokemon = viewModel.pokemon {
                ScrollView {
                    VStack(spacing: 20) {
                        ZStack {
                           // Color(hex: pokemon.primaryTypeColor)
                               // .edgesIgnoringSafeArea(.top)
                               // .frame(height: 300)

                            AsyncImage(url: URL(string: pokemon.image)) { phase in
                                switch phase {
                                case .success(let image):
                                    image.resizable()
                                        .scaledToFit()
                                        .frame(width: 200, height: 200)
                                case .failure:
                                    Image(systemName: "exclamationmark.triangle")
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100, height: 100)
                                        .foregroundColor(.red)
                                default:
                                    ProgressView()
                                }
                            }
                        }

                        VStack(alignment: .leading, spacing: 10) {
                            Text("#\(String(format: "%03d", pokemon.id)) \(pokemon.name)")
                                .font(.title)
                                .bold()
                            Text(pokemon.types.joined(separator: ", "))
                                .font(.headline)
                                .foregroundColor(.secondary)

                            TabView {
                                VStack(alignment: .leading) {
                                    Text("À propos")
                                        .font(.title2)
                                        .bold()
                                    Text(pokemon.description)
                                        .font(.body)

                                    Divider()

                                    HStack {
                                        Text("Espèce : \(pokemon.species)")
                                        Spacer()
                                        Text("Taille : \(pokemon.height) m")
                                    }
                                    .font(.subheadline)

                                    HStack {
                                        Text("Poids : \(pokemon.weight) kg")
                                        Spacer()
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
                                .padding()
                                .tabItem {
                                    Label("À propos", systemImage: "info.circle")
                                }

                                VStack(alignment: .leading) {
                                    Text("Statistiques de base")
                                        .font(.title2)
                                        .bold()
                                    ForEach(pokemon.stats, id: \.name) { stat in
                                        HStack {
                                            Text(stat.name)
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

                                VStack {
                                    Text("Évolutions")
                                        .font(.title2)
                                        .bold()
                                    ForEach(pokemon.evolutions, id: \.id) { evolution in
                                        NavigationLink(destination: PokemonDetailView(idOrName: "\(evolution.id)")) {
                                            HStack {
                                                AsyncImage(url: URL(string: evolution.image)) { phase in
                                                    switch phase {
                                                    case .success(let image):
                                                        image.resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                    case .failure:
                                                        Image(systemName: "exclamationmark.triangle")
                                                            .resizable()
                                                            .scaledToFit()
                                                            .frame(width: 50, height: 50)
                                                            .foregroundColor(.red)
                                                    default:
                                                        ProgressView()
                                                    }
                                                }
                                                Text(evolution.name)
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
