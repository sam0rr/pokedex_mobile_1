import SwiftUI

struct HeaderView: View {
    let pokemon: PokemonDetail

    var body: some View {
        ZStack {
            // Background
            Color.blue.opacity(0.2)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 250)
            
            VStack(spacing: 16) {
                // Large Pokémon Name in Background
                Text(pokemon.name.uppercased())
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.blue.opacity(0.1))
                    .padding(.top, 40)
                    .overlay(
                        // Pokémon ID and Name
                        VStack {
                            Text("#\(String(format: "%03d", pokemon.id))")
                                .font(.subheadline)
                                .foregroundColor(.gray)
                            Text(pokemon.name.capitalized)
                                .font(.title)
                                .fontWeight(.bold)
                                .foregroundColor(.black)
                        }
                    )

                // Pokémon Types
                HStack(spacing: 8) {
                    ForEach(pokemon.types, id: \.self) { type in
                        PokemonTypeChip(typeName: type)
                    }
                }

                // Pokémon Image
                AsyncImage(url: URL(string: pokemon.imageURL)) { image in
                    image.resizable()
                        .scaledToFit()
                        .frame(height: 150)
                } placeholder: {
                    ProgressView()
                        .frame(height: 150)
                }
            }
        }
    }
}
