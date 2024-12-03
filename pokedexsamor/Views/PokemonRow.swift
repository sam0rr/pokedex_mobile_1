import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack {
            // Background color based on the first type
            (TypeColors.colors[pokemon.types.first?.lowercased() ?? "normal"] ?? Color.gray)
                .lighter(by: 0.15) // Make the background lighter
                .cornerRadius(15)

            HStack {
                // Pokémon ID and Favorite Heart
                VStack(alignment: .leading) {
                    HStack {
                        Text("#\(String(format: "%03d", pokemon.id))")
                            .font(.headline)
                            .bold()
                            .foregroundColor(.black)

                        if pokemon.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding(.bottom, 1)

                    // Pokémon Name
                    Text(pokemon.name)
                        .font(.title2)
                        .bold()
                        .foregroundColor(.white)
                        .padding(.bottom, 1)

                    // Pokémon Types
                    HStack {
                        ForEach(pokemon.types, id: \.self) { type in
                            PokemonTypeChip(typeName: type)
                        }
                    }
                }
                Spacer()

                // Pokémon Image
                AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
                    switch phase {
                    case .empty:
                        ProgressView()
                            .frame(width: 80, height: 80)
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .offset(x: 10) // Overlaps the row slightly
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .offset(x: 10) // Overlaps the row slightly
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .padding(.horizontal, 16) // Adds padding inside the row
            .padding(.vertical, 12)  // Adds vertical spacing for inner elements
        }
        .padding(8) // Adds padding around the entire row
    }
}
