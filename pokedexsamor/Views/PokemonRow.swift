import SwiftUI

struct PokemonRow: View {
    let pokemon: Pokemon

    var body: some View {
        HStack {
            AsyncImage(url: URL(string: pokemon.imageUrl)) { image in
                image.resizable().scaledToFit()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 50, height: 50)

            VStack(alignment: .leading) {
                Text("#\(String(format: "%03d", pokemon.id)) \(pokemon.name)")
                    .font(.headline)
                Text(pokemon.types.joined(separator: ", "))
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
    }
}
