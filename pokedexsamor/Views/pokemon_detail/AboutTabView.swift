import SwiftUI

struct AboutTabView: View {
    let pokemon: PokemonDetail
    let typeColor: Color

    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                // Description Section
                if !pokemon.description.isEmpty {
                    Text(pokemon.description)
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
                        Text(pokemon.speciesName)
                            .font(.body)
                            .foregroundColor(.gray)
                        Text("\(Int(round(Double(pokemon.height) / 10)))")
                            .font(.body)
                            .foregroundColor(.gray)
                        Text("\(Int(round(Double(pokemon.weight) / 10)))")
                            .font(.body)
                            .foregroundColor(.gray)
                    }
                    .padding(.leading, 30)
                    .padding(.bottom, 8)
                }

                if !pokemon.weaknesses.isEmpty {
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Faiblesses")
                            .font(.headline)
                            .bold()
                            .foregroundColor(typeColor)
                            .padding(.bottom, 8)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 8) {
                                ForEach(pokemon.weaknesses, id: \.self) { weakness in
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
            .padding(.leading, 20)
            .padding(.vertical, 16)
        }
    }
}
