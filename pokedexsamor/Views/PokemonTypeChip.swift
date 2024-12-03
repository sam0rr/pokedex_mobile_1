import SwiftUI

struct PokemonTypeChip: View {
    let typeName: String

    var body: some View {
        HStack(spacing: 4) {
            // Type Icon
            Image(typeName.lowercased()) // Assumes asset names match type names
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)

            // Type Name
            Text(typeName.capitalized)
                .font(.caption)
                .bold()
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 6)
        .background(
            Color(typeName.lowercased())
        )
        .cornerRadius(3) // Rounded corners for the chip
        .foregroundColor(.white) // Text and icon color
    }
}

// Preview
struct PokemonTypeChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonTypeChip(typeName: "grass")
            PokemonTypeChip(typeName: "fire")
            PokemonTypeChip(typeName: "water")
            PokemonTypeChip(typeName: "poison")
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
