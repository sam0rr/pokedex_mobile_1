import SwiftUI

struct HeaderView: View {
    let pokemon: PokemonDetail

    var body: some View {
        ZStack {
            Color(pokemon.types.first?.lowercased() ?? "normal")
                .lighter(by: 0.15)
                .edgesIgnoringSafeArea(.top)
                .frame(height: 300)

            VStack(spacing: 16) {

                Text(pokemon.name.capitalized)
                    .font(.system(size: 64, weight: .bold))
                    .foregroundColor(.white.opacity(0.2))
                    .padding(.bottom, -40)

                Spacer()

                HStack(alignment: .top, spacing: 16) {

                    AsyncImage(url: URL(string: pokemon.imageURL)) { image in
                        image.resizable()
                            .scaledToFit()
                            .frame(width: 120, height: 120, alignment: .top)
                    } placeholder: {
                        ProgressView()
                            .frame(width: 120, height: 120)
                    }
                    
                    Spacer()

                    VStack(alignment: .leading, spacing: 8) {
                        HStack(spacing: 8) {
                            Text("#\(String(format: "%03d", pokemon.id))")
                                .font(.system(size: 16))
                                .bold()
                                .foregroundColor(.black)

                            if pokemon.isFavorite {
                                Image(systemName: "heart.fill")
                                    .font(.system(size: 16))
                                    .foregroundColor(.red)
                            }
                        }

                        Text(pokemon.name.capitalized)
                            .font(.system(size: 30, weight: .bold))
                            .foregroundColor(.white)
                            .padding(.bottom, 8)

                        HStack(spacing: 8) {
                            ForEach(pokemon.types, id: \.self) { type in
                                PokemonTypeChip(typeName: type)
                            }
                        }
                    }
                }
                Spacer()
            }
            .padding(.top, 40)
            .padding(.horizontal, 30)
        }
    }
}
