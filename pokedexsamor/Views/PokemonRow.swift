import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon

    var body: some View {
        HStack {
            // Asynchronous image loading
            AsyncImage(url: URL(string: pokemon.imageURL)) { phase in
                switch phase {
                case .success(let image):
                    image
                        .resizable()
                        .scaledToFit()
                case .failure:
                    // Fallback for failed image loading
                    Image(systemName: "photo")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.gray)
                case .empty:
                    // Placeholder while loading
                    ProgressView()
                }
            }
            .frame(width: 50, height: 50)
            .clipShape(RoundedRectangle(cornerRadius: 8)) // Rounded corners for aesthetics
            .accessibilityLabel("Image of \(pokemon.name)")

            // Pokémon details
            VStack(alignment: .leading) {
                Text("#\(String(format: "%03d", pokemon.id)) \(pokemon.name)")
                    .font(.headline)
                    .accessibilityLabel("Pokémon name: \(pokemon.name), ID: \(pokemon.id)")
                Text(pokemon.types.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .accessibilityLabel("Types: \(pokemon.types.joined(separator: ", "))")
            }
        }
        .padding(.vertical, 4) // Add padding for better spacing
    }
}
