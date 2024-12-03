import SwiftUI

struct PokemonTypeChip: View {
    let typeName: String

    var body: some View {
        HStack(spacing: 4) {
            Image(typeName.lowercased())
                .resizable()
                .scaledToFit()
                .frame(width: 16, height: 16)

            Text(typeName.capitalized)
                .font(.caption)
                .bold()
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 6)
        .background(
            Color(typeName.lowercased())
        )
        .cornerRadius(3)
        .foregroundColor(.white)
    }
}

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
