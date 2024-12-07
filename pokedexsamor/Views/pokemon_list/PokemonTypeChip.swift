import SwiftUI

struct PokemonTypeChip: View {
    let typeName: String
    var width: CGFloat? = nil
    var height: CGFloat? = nil
    var isSelected: Bool = false

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
        .frame(
            width: width ?? nil,
            height: height ?? nil
        )
        .background(
            Color(typeName.lowercased())
        )
        .brightness(isSelected ? 0.35 : 0)
        .cornerRadius(3)
        .foregroundColor(.white)
    }
}

struct PokemonTypeChip_Previews: PreviewProvider {
    static var previews: some View {
        Group {
            PokemonTypeChip(typeName: "grass", isSelected: false)
            PokemonTypeChip(typeName: "fire", width: 100, height: 40, isSelected: true)
            PokemonTypeChip(typeName: "water", width: 80, isSelected: true)
            PokemonTypeChip(typeName: "poison", height: 30, isSelected: false)
        }
        .previewLayout(.sizeThatFits)
        .padding()
    }
}
