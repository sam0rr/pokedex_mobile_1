import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon

    var body: some View {
        ZStack {
            // Background color from assets based on the first type, lightened
            (Color(pokemon.types.first?.lowercased() ?? "normal")
                .lighter(by: 0.15)) // Lighten the background color
                .cornerRadius(15)

            HStack {
                // Pokémon ID and Favorite Heart
                VStack(alignment: .leading) {
                    HStack {
                        Text("#\(String(format: "%03d", pokemon.id))")
                            .font(.system(size: 12))
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
                            .frame(width: 100, height: 100)
                            .offset(x: 0, y: -40) // Move image above the row
                    case .success(let image):
                        image
                            .resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120) // Slightly larger image
                            .offset(x: 0, y: -40) // Move image above the row
                    case .failure:
                        Image(systemName: "photo")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100, height: 100)
                            .offset(x: 0, y: -40) // Move image above the row
                    @unknown default:
                        EmptyView()
                    }
                }
            }
            .padding(.horizontal, 12) // Adds padding inside the row
        }
        .padding(10) // Adds padding around the entire row
    }
}
