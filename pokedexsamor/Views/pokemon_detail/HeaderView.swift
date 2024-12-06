import SwiftUI

struct HeaderView: View {
    let pokemon: PokemonDetail

    var body: some View {
        ZStack {
            // Background color based on the Pokemon's type
            Color(pokemon.types.first?.lowercased() ?? "normal")
                .lighter(by: 0.15)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300) // Make the background cover the top area

            VStack(spacing: 16) {
                Text(pokemon.name.uppercased())
                    .font(.system(size: 60, weight: .bold))
                    .foregroundColor(.blue.opacity(0.1)) // Set text color as desired
                    .padding(.top, 40)
                    .overlay(
                        HStack(spacing: 8) {
                            VStack {
                                Text("#\(String(format: "%03d", pokemon.id))")
                                    .font(.subheadline)
                                    .foregroundColor(.gray)
                            }
                        }
                    )

                HStack(spacing: 8) {
                    // Displaying the Pokemon types
                    ForEach(pokemon.types, id: \.self) { type in
                        PokemonTypeChip(typeName: type) // Your custom chip component
                    }
                }

                // Displaying the Pokémon's image
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
