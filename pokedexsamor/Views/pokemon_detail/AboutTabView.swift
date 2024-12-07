import SwiftUI

struct AboutTabView: View {
    let pokemon: PokemonDetail
    let typeColor: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                if let description = pokemon.description, !description.isEmpty {
                    Text(description)
                        .font(.body)
                        .foregroundColor(.gray)
                        .multilineTextAlignment(.leading)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(.bottom, 16)
                }

                Text("Données du Pokédex")
                    .font(.headline)
                    .bold()
                    .foregroundColor(typeColor)
                    .padding(.bottom, 8)

                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text("Espèce")
                            .font(.body)
                            .bold()
                            .foregroundColor(.black)
                        Text("Hauteur")
                            .font(.body)
                            .bold()
                            .foregroundColor(.black)
                        Text("Poids")
                            .font(.body)
                            .bold()
                            .foregroundColor(.black)
                    }

                    VStack(alignment: .leading, spacing: 12) {
                        Text(pokemon.speciesName ?? "N/A")
                            .font(.body)
                            .foregroundColor(.gray)

                        if let height = pokemon.height {
                            Text("\(Int(round(Double(height) / 10)))")
                                .font(.body)
                                .foregroundColor(.gray)
                        } else {
                            Text("N/A")
                                .font(.body)
                                .foregroundColor(.gray)
                        }

                        if let weight = pokemon.weight {
                            Text("\(Int(round(Double(weight) / 10)))")
                                .font(.body)
                                .foregroundColor(.gray)
                        } else {
                            Text("N/A")
                                .font(.body)
                                .foregroundColor(.gray)
                        }
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 8)
                }

                if let weaknesses = pokemon.weaknesses, !weaknesses.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Faiblesses")
                            .font(.headline)
                            .bold()
                            .foregroundColor(typeColor)
                            .padding(.bottom, 8)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(weaknesses, id: \.self) { weakness in
                                    Image(weakness.lowercased())
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 32, height: 32)
                                        .padding(2)
                                }
                            }
                        }
                    }
                }
            }
            .padding(.leading, 40)
            .padding(.top, 50)
            .padding(.bottom, 40)
            .padding(.trailing, 40)
        }
    }
}
