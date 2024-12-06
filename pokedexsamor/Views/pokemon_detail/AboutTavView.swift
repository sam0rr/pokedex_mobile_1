import SwiftUI

struct AboutTabView: View {
    let pokemon: PokemonDetail
    let typeColor: Color // Pass the Pokémon's type color

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Données du Pokédex")
                .font(.headline)
                .bold()
                .foregroundColor(typeColor) // Apply the dynamic type color
                .padding(.bottom, 8)
            
            VStack(alignment: .leading, spacing: 4) {
                Text("Espèce: \(pokemon.speciesName)")
                Text("Hauteur: \(Double(pokemon.height) / 10) m")
                Text("Poids: \(Double(pokemon.weight) / 10) kg")
            }
            .font(.body)
            
            if !pokemon.weaknesses.isEmpty {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Faiblesses")
                        .font(.headline)
                        .bold()
                        .foregroundColor(typeColor) // Apply the dynamic type color
                    
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 8) {
                            ForEach(pokemon.weaknesses, id: \.self) { weakness in
                                PokemonTypeChip(typeName: weakness)
                            }
                        }
                    }
                }
            }
        }
        .padding()
    }
}
