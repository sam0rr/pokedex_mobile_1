import SwiftUI

struct AboutTabView: View {
    let pokemon: PokemonDetail

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text("Données du Pokédex")
                .font(.headline)
            Text("Espèce: \(pokemon.speciesName)")
            Text("Hauteur: \(pokemon.height)")
            Text("Poids: \(pokemon.weight)")

            if !pokemon.weaknesses.isEmpty {
                Text("Faiblesses")
                    .font(.headline)
                HStack {
                    ForEach(pokemon.types, id: \.self) { type in
                        PokemonTypeChip(typeName: type)
                    }
                }
            }
        }
        .padding()
    }
}
